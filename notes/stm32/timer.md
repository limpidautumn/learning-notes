# 定时器

## 基本定时器
### 计数
时钟信号 -> 预分频器 -> 计数器

预分频器 / 计数器 容量均为 16bit。

如需对输入时钟进行 $n$ 分频 $(n \le 65536)$，则设置 预分频器(prescaler) 为 $n-1$。

### 中断
如需每 $m$ 个脉冲触发一次中断 $(m \le 65536)$，则设置 自动重装载寄存器(TIMx_ARR) 为 $m-1$。

### HAL 库用法
```cpp
HAL_StatusTypeDef HAL_TIM_Base_Start(TIM_HandleTypeDef *htim); // 启用定时器基础计时功能
```

## 通用定时器
TIM2 - TIM4

### CubeMX 配置
`Timers > TIMx`

1. 开启：勾选 `Mode > [x] Internal Clock`，或将 `Mode > Clock Source` 选为 `Internal Clock`
2. 预分频器：`Configuration > Counter Settings > Prescaler (PSC - 16 bits value)`
3. 自动重装载寄存器：`Configuration > Counter Settings > Counter Period (AutoReload Register - 16 bits value)`

## 高级定时器
TIM1
