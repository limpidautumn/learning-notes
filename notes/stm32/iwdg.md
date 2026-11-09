# 独立看门狗 (IWDG)

个人学习笔记，只记常用功能，不保证正确。请以 ST 手册上的内容为准。

## STM32F1 系列

### 工作原理

IWDG 是一个自由运行的 12 位递减计数器，由 LSI 时钟信号驱动。

```
LSI (40 kHz) -> 12-bit prescaler -> 12-bit downcounter -> IWDG reset
```

#### 基础看门

IWDG 启动后，计数器从 4095 开始向下计数；计数到 0 时，触发单片机复位。在此期间，软件需要向 IWDG_KR.KEY[15:0] 寄存器中写 0xAAAA，以重装载计数器至 IWDG_RLR:RL[11:0]。

写 IWDG_KR 的过程，被称为“喂狗”操作。

> **RM0008 Rev 21 §19.3 IWDG functional description**
> 
> When the independent watchdog is started by writing the value 0xCCCC in the Key register (IWDG_KR), the counter starts counting down from the reset value of 0xFFF. When it reaches the end of count value (0x000) a reset signal is generated (IWDG reset).
> 
> Whenever the key value 0xAAAA is written in the IWDG_KR register, the IWDG_RLR value is reloaded in the counter and the watchdog reset is prevented.

#### 调试

调试器在断点调试时，会将 Cortex-M3 内核 halt 住，进入调试状态 (debug state)。我们希望此时 IWDG 停止计数。

写 DBGMCU_CR.DBG_IWDG_STOP[8]=1，以在调试状态停止计数。该配置在全速运行时不起作用。

> **RM0008 Rev 21 §31.16.3 Debug MCU configuration register, DBGMCU_CR register**
> 
> Bit 8, **DBG_IWDG_STOP**: Debug independent watchdog stopped when core is halted
> - 0: The watchdog counter clock continues even if the core is halted
> - 1: The watchdog counter clock is stopped when the core is halted

### CubeMX 配置

```text
System Core > IWDG
- Mode
  - [x] Activated  # 生成 hiwdg 句柄, 并在 main() 中调用 MX_IWDG_Init().
- Configuration
  - Watchdog Clocking
    - IWDG counter clock prescaler: 4/8/16/32/64/128/256  # IWDG_PR.PR[2:0]
    - IWDG down-counter reload value: 0~4095  # IWDG_RLR.RL[11:0]
```

### HAL 库用法

```cpp
// 在 MX_IWDG_Init 之前执行:
#if defined(DEBUG)  // CubeIDE, Debug 配置
__HAL_DBGMCU_FREEZE_IWDG();  // 在调试状态冻结看门狗
#endif

// 主循环中定时执行:
HAL_IWDG_Refresh(&hiwdg);  // 喂看门狗
```

### 参考材料

- [RM0008 - ST](https://www.st.com/resource/en/reference_manual/rm0008-stm32f101xx-stm32f102xx-stm32f103xx-stm32f105xx-and-stm32f107xx-advanced-armbased-32bit-mcus-stmicroelectronics.pdf)

## STM32F0 系列

### 工作原理

基础功能与 STM32F1 系列基本一致。新增窗口选项。

#### 窗口

若向 IWDG_KR.KEY[15:0] 写 0xAAAA 时，计数器的值大于 IWDG_WINR.WIN[11:0]，则触发单片机复位。

> **RM0360 Rev 5 §19.3.2 Window option**
> 
> The IWDG can also work as a window watchdog by setting the appropriate window in the IWDG window register (IWDG_WINR).
> 
> If the reload operation is performed while the counter is greater than the value stored in the IWDG window register (IWDG_WINR), then a reset is provided.

### CubeMX 配置

```text
System Core > IWDG
# 基础配置方法与 STM32F1 一致, 略.
- Configuration
  - Watchdog Clocking
    - IWDG window value: 0~4095  # IWDG_WINR.WIN[11:0]
```

### 参考材料

- [RM0360 - ST](https://www.st.com/resource/en/reference_manual/rm0360-stm32f030x4x6x8xc-and-stm32f070x6xb-advanced-armbased-32bit-mcus-stmicroelectronics.pdf)
