# GPIO 引脚

个人学习笔记，只记常用功能，不保证正确。请以 ST 手册上的内容为准。

## 工作模式

| 名称 | 备注 |
| :--: | :--: |
| 推挽输出 | 高/低电平 对应 VSS/VDD |
| 开漏输出 | 高/低电平 对应 高阻态/VDD |
| 复用推挽输出 | 片上外设 |
| 复用开漏输出 | 片上外设 |
| 浮空输入 | 施密特触发器 |
| 上拉输入 | / |
| 下拉输入 | / |
| 模拟输入 | / |

“复用”：控制权转移。

## 电气特性

### STM32F103C8T6

低电平 0 - 35%

内部弱上/下拉阻值 30kΩ~50kΩ, 典型值 40kΩ.

> **DS5319 Rev 20 §5.3.13 I/O port characteristics, General input/output characteristics**
> 
> **DS5319 Rev 20 Table 36. I/O static characteristics**
> 
> Low / high level input voltage (V<sub>IL</sub>, V<sub>IH</sub>, all I/Os except BOOT0): V<sub>IL</sub> Max = 0.35 V<sub>DD</sub>, V<sub>IH</sub> Min = 0.65 V<sub>DD</sub>.
> 
> Weak pull-up / pull-down equivalent resistor (R<sub>PU</sub>, R<sub>PD</sub>):  Min = 30kΩ, Typ = 40kΩ, Max = 50kΩ.

## HAL 库调用

```c
// 读取引脚电平
HAL_GPIO_ReadPin(GPIO_TypeDef *GPIOx, uint16_t GPIO_Pin);

// 写入引脚电平
HAL_GPIO_WritePin(GPIO_TypeDef *GPIOx, uint16_t GPIO_Pin, GPIO_PinState PinState);

// 切换引脚电平
HAL_GPIO_TogglePin(GPIO_TypeDef *GPIOx, uint16_t GPIO_Pin);
```
