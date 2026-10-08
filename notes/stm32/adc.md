# ADC

以 **STM32F103C8T6** 芯片为例。

个人学习笔记，不保证正确。请以 ST 手册上的内容为准。

参考资料：
- [RM0008 - ST](https://www.st.com/resource/en/reference_manual/rm0008-stm32f101xx-stm32f102xx-stm32f103xx-stm32f105xx-and-stm32f107xx-advanced-armbased-32bit-mcus-stmicroelectronics.pdf)

## 基础信息
- 12-bit ADC
- 逐次逼近型模数转换器 (SAR ADC)
- 18 个通道 = 16 外部 + 2 内部. STM32F103C8T6 可用 10 个外部通道.
- ADCCLK: 由 PCLK2 经预分频器产生, 频率**不得超过 14MHz**

## 主要特性

- 12 位分辨率
- 在转换结束、注入转换结束和模拟看门狗事件时产生中断
- 单次 (single) 和连续 (continous) 转换模式
- 用于自动转换通道 0 到通道 n 的扫描 (scan) 模式
- 自校准
- 具有内置数据一致性的数据对齐
- 逐通道可编程采样时间
- 规则转换和注入转换均可选择外部触发
- 间断 (discontinous) 模式
- 双重 (dual) 模式（在具有 2 个或更多 ADC 的器件上）
- ADC 转换时间：
  - STM32F103xx 增强型器件：在 72 MHz 时为 1.17 μs<!-- 在 56 MHz 时为 1 μs（在 72 MHz 时为 1.17 μs） -->
  <!--
  - STM32F101xx 基本型器件：在 28 MHz 时为 1 μs（在 36 MHz 时为 1.55 μs）
  - STM32F102xx USB 基本型器件：在 48 MHz 时为 1.2 μs
  - STM32F105xx 和 STM32F107xx 器件：在 56 MHz 时为 1 μs（在 72 MHz 时为 1.17 μs）
  -->
- ADC 电源要求：2.4 V 至 3.6 V
- ADC 输入范围：VREF- ≤ VIN ≤ VREF+
- 在规则 (regular) 通道转换期间产生 DMA 请求

<div align="center">
  <img src="assets/rm0008_rev21/figure_22.svg" alt="RM0008 Rev 21 Figure 22. Single ADC block diagram" width="70%">
</div>

<!-- 注：如果 VREF- 可用（取决于封装），则必须将其连接到 VSSA。 -->

## Single conversion mode

单次转换模式：ADC 执行一次转换。

ADC_CR2:CONT=0 时：
- 置 ADC_CR2:ADON=1 启动 (仅 regular channel).
- 外部触发启动 (regular / injected channel).

转换完成后：
- Regular channel: 数据写入 ADC_DR；置 ADC_SR:EOC=1；产生中断。
- Injected channel：数据写入 ADC_DRJ1；产生中断。

随后 ADC 停止。

相关寄存器: [ADC_SR.EOC](#adc_sreoc).

> **RM0008 Rev 21 §11.3.4 Single conversion mode**
> 
> In Single conversion mode the ADC does one conversion. This mode is started either by setting the ADON bit in the ADC_CR2 register (for a regular channel only) or by external trigger (for a regular or injected channel), while the CONT bit is 0.
> 
> Once the conversion of the selected channel is complete:
> - If a regular channel was converted:
>   - The converted data is stored in the 16-bit ADC_DR register
>   - The EOC (End Of Conversion) flag is set
>   - and an interrupt is generated if the EOCIE is set.
> - If an injected channel was converted:
>   - The converted data is stored in the 16-bit ADC_DRJ1 register
>   - The JEOC (End Of Conversion Injected) flag is set
>   - and an interrupt is generated if the JEOCIE bit is set.
> 
> The ADC is then stopped.

## Continous conversion mode

连续转换模式：ADC 完成一次转换后，立即开始下一次。

ADC_CR2:CONT=1, 其余同 Single conversion mode.

> **RM0008 Rev 21 §11.3.5 Continuous conversion mode**
> 
> In continuous conversion mode ADC starts another conversion as soon as it finishes one. This mode is started either by external trigger or by setting the ADON bit in the ADC_CR2 register, while the CONT bit is 1.
> 
> After each conversion:
> - If a regular channel was converted:
>   - The converted data is stored in the 16-bit ADC_DR register
>   - The EOC (End Of Conversion) flag is set
>   - An interrupt is generated if the EOCIE is set.
> - If an injected channel was converted:
>   - The converted data is stored in the 16-bit ADC_DRJ1 register
>   - The JEOC (End Of Conversion Injected) flag is set
>   - An interrupt is generated if the JEOCIE bit is set.

## Scan mode

扫描模式：扫描选中的所有通道。每个通道转换一次，并自动切换到下一通道。若 ADC_CR2:CONT=1，则在最后一个选定通道后从第一个选定通道重新开始。

软件置 ADC_CR1:SCAN=1 开启.

- 规则通道 (regular):
  - 序列寄存器为 ADC_SQRx;
  - 置 ADC_CR2:DMA=1, 数据通过 DMA 搬运到内存中.
- 注入通道 (injected):
  - 序列寄存器为 ADC_JSQR;
  - 数据存储在 ADC_JDRx 中.

> **RM0008 Rev 21 §11.3.8 Scan mode**
> 
> This mode is used to scan a group of analog channels.
> 
> Scan mode can be selected by setting the SCAN bit in the ADC_CR1 register. Once this bit is set, ADC scans all the channels selected in the ADC_SQRx registers (for regular channels) or in the ADC_JSQR (for injected channels). A single conversion is performed for each channel of the group. After each end of conversion the next channel of the group is converted automatically. If the CONT bit is set, conversion does not stop at the last selected group channel but continues again from the first selected group channel.
> 
> When using scan mode, DMA bit must be set and the direct memory access controller is used to transfer the converted data of regular group channels to SRAM after each update of the ADC_DR register.
> 
> The injected channel converted data is always stored in the ADC_JDRx registers.

## 校准

建议每次上电后都执行一次校准。在开始校准之前，ADC 必须已处于上电状态 (ADC_CR2:ADON=1) 至少两个 ADC 时钟周期。

校准写 ADC_CR2:CAL=1。校准完成后 ADC_CR2:CAL 被硬件复位，校准码写入 ADC_DR。

> **RM0008 Rev 21 §11.4 Calibration**
> 
> The ADC has an built-in self calibration mode. Calibration significantly reduces accuracy errors due to internal capacitor bank variations. During calibration, an error-correction code (digital word) is calculated for each capacitor, and during all subsequent conversions, the error contribution of each capacitor is removed using this code.
> 
> Calibration is started by setting the CAL bit in the ADC_CR2 register. Once calibration is over, the CAL bit is reset by hardware and normal conversion can be performed. It is recommended to calibrate the ADC once at power-on. The calibration codes are stored in the ADC_DR as soon as the calibration phase ends.
> 
> Note:
> - It is recommended to perform a calibration after each power-up.
> - Before starting a calibration, the ADC must have been in power-on state (ADON bit = ‘1’) for at least two ADC clock cycles.

## 温度传感器

TODO

## 嵌入式基准电压

V<sub>REFINT</sub> = 1.20V, 采样时间 ≤ 17.1 μs

> **DS5319 Rev 20 §5.3.4 Embedded reference voltage**
> The parameters given in Table 12 are derived from tests performed under ambient temperature and VDD supply voltage conditions summarized in Table 9.
> 
> Table 12. Embedded internal reference voltage
> | Symbol | Parameter | Conditions | Min | Typ | Max | Unit |
> | :--: | :--- | :--: | :--: | :--: | :--: | :--: |
> | V<sub>REFINT</sub> | Internal reference voltage | -40℃<T<sub>A</sub><+105℃ | 1.16 | 1.20 | 1.26 | V |
> | V<sub>REFINT</sub> | Internal reference voltage | -40℃<T<sub>A</sub><+85℃ | 1.16 | 1.20 | 1.24 | V |
> | T<sub>S_vrefint</sub><sup>(1)</sup> | ADC sampling time when reading the internal reference voltage | - | - | 5.1 | 17.1<sup>(2)</sup> | μs |
> | V<sub>REFINT</sub><sup>(2)</sup> | Internal reference voltage spread over the temperature range | V<sub>DD</sub>=3V±10mV | - | - | 10 | mV |
> | T<sub>Coeff</sub><sup>(2)</sup> | Temperature coefficient | - | - | - | 100 | ppm/℃ |
> 1. Shortest sampling time can be determined in the application by multiple iterations.
> 2. Specified by design, not tested in production.

## 寄存器
### ADC_SR.EOC
读 ADC_DR 时，硬件自动清零；也可由软件清零。

> **RM0008 Rev 21 §11.12.1 ADC status register (ADC_SR)**
> 
> Bit 1 **EOC**: End of conversion
> 
> This bit is set by hardware at the end of a group channel conversion (regular or injected). It is cleared by software or by reading the ADC_DR.
> 
> 0: Conversion is not complete  
> 1: Conversion complete

HAL 库中，`HAL_ADC_IRQHandler` 对 EOC 进行了软件清零。

## CubeMX 配置

以 STM32F103C8T6 为例。

```
Analog > ADCx > ADCx Mode and Configuration

- Mode
  - [ ] INx
  - [ ] Temperature Sensor Channel
  - [ ] Vrefint Channel
  - EXTI Conversion Trigger: Disabled / Injected Trigger / Regular Trigger / Injected and Regular Trigger
- Configuration
  - Parameter Settings
    - ADCs_Common_Settings
      - Mode: Independent mode / Dual combined regular simultaneous + injected simultaneous mode / Dual regular simultaneous + alternate trigger mode / Dual combined injected simultaneous + fast interleaved mode (delay between ADC sampling phases: 7 ADC clock cycles) / Dual combined injected simultaneous + slow interleaved mode (delay between ADC sampling phases: 14 ADC clock cycles) / Dual injected simultaneous mode only / Dual regular simultaneous mode only / Dual fast interleaved mode only (delay between ADC sampling phases: 7 ADC clock cycles) / Dual slow interleaved mode only (delay between ADC sampling phases: 14 ADC clock cycles) / Dual alternate trigger mode only
    - ADC_Settings
      - Data Alignment: Right alignment / Left alignment
      - Scan Conversion Mode: Disabled / Enabled
      - Continous Conversion Mode: Disabled / Enabled
      - Discontinous Conversion Mode: Disabled / Enabled
    - ADC_Regular_ConversionMode
      - Enable Regular Conversions: Enable / Disable
      - Number Of Conversion: x
      - External Trigger Conversion Source: Regular Conversion launched by software / Timer x Capture Compare x event / Timer x Trigger Out event / EXTI Line x
      - Rank x
        - Channel: Channel x
        - Sampling Time: x Cycles
    - ADC_Injected_ConversionMode
      - Enable Injected Conversions: Disable / Enable
      - Number Of Conversion: x
      - External Trigger Conversion Source: Injected Conversion launched by software / Timer x Capture Compare x event / Timer x Trigger Out event / EXTI Line x
      - Rank x
        - Channel: Channel x
        - Sampling Time: x Cycles
        - Injected Offset: x
    - WatchDog
      - Enable Analog WatchDog Mode: [ ]
  - NVIC Settings
  - DMA Settings
  - GPIO Settings
```

> 铃兰火腿烤格子 from BiliBili:  
> stm32f4使用adc持续转换+dma存储数据需要开启这个: Analog > ADC1 > ADC1 Mode and Configuration > Configuration > Parameter Settings > ADC_Settings > DMA Continous Requests: Enabled.  
> [BV1QNz6YuE2x](https://www.bilibili.com/video/BV1QNz6YuE2x/) 评论区, 2025年6月20日 广东

## HAL 库用法
```cpp
HAL_StatusTypeDef HAL_ADCEx_Calibration_Start(ADC_HandleTypeDef* hadc);  // 执行内部自校准

HAL_StatusTypeDef HAL_ADC_PollForConversion(ADC_HandleTypeDef* hadc, uint32_t Timeout);  // 轮询方式等待 ADC 转换完成
HAL_StatusTypeDef HAL_ADC_Start(ADC_HandleTypeDef* hadc);  // 启动 ADC 规则通道 (regular channel) 转换
HAL_StatusTypeDef HAL_ADC_Start_IT(ADC_HandleTypeDef* hadc);  // 启动, 并使能转换完成 (EOC) 中断

// ADC 规则组 (regular group) 转换完成回调函数
// Start_IT 启动时, 为 EOC 中断回调;
// Start_DMA 启动时, 为 DMA 传输完成中断回调.
__weak void HAL_ADC_ConvCpltCallback(ADC_HandleTypeDef* hadc) {}

uint32_t HAL_ADC_GetValue(ADC_HandleTypeDef* hadc);  // 读取 ADC_DR 的值
```
