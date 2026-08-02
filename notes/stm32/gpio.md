# GPIO 引脚

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

## HAL 库调用

```c
// 读取引脚电平
HAL_GPIO_ReadPin(GPIO_TypeDef *GPIOx, uint16_t GPIO_Pin);

// 写入引脚电平
HAL_GPIO_WritePin(GPIO_TypeDef *GPIOx, uint16_t GPIO_Pin, GPIO_PinState PinState);

// 切换引脚电平
HAL_GPIO_TogglePin(GPIO_TypeDef *GPIOx, uint16_t GPIO_Pin);
```
