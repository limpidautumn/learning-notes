# 串口通信
[轮询 - 视频教程](https://www.bilibili.com/video/BV1Na4y1T7VQ/)
[原理/中断 - 视频教程](https://www.bilibili.com/video/BV1bc411J7Tv/)

## CubeMX 配置
以 USART2 配置 TTL (UART) 为例

开启片上外设，配置工作模式：`Pinout & Configuration > Connectivity > USART2 > Mode > Mode: Asynchronous`

配置波特率：`Pinout & Configuration > Connectivity > USART2 > Configuration > Parameter Settings > Basic Parameters > Baud Rate`

开启中断：`Pinout & Configuration > System Core > NVIC > Configuration > NVIC Interrupt Table > USART2 global interrupt [x]`

## HAL 库调用

```c
// 轮询发送
HAL_UART_Transmit(UART_HandleTypeDef *huart, const uint8_t *pData, uint16_t Size, uint32_t Timeout);
// 当消息为字符串时，注意不要让 '\0' 被发送。

// 轮询接收
HAL_UART_Receive(UART_HandleTypeDef *huart, uint8_t *pData, uint16_t Size, uint32_t Timeout);

// 中断发送
HAL_UART_Transmit_IT(UART_HandleTypeDef *huart, const uint8_t *pData, uint16_t Size);

// 中断接收
HAL_UART_Receive_IT(UART_HandleTypeDef *huart, uint8_t *pData, uint16_t Size);
void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart) {} // 接收完成动作

// DMA 发送/接收
HAL_UART_Transmit_DMA(UART_HandleTypeDef *huart, const uint8_t *pData, uint16_t Size);
HAL_UART_Receive_DMA(UART_HandleTypeDef *huart, uint8_t *pData, uint16_t Size);
void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart) {}

// 不定长数据接收
HAL_UARTEx_ReceiveToIdle_DMA(UART_HandleTypeDef *huart, uint8_t *pData, uint16_t Size); // 持续接收数据，直到空闲
__HAL_DMA_DISABLE_IT(&hdma_usart2_rx, DMA_IT_HT); // 禁用 DMA 半传输中断
void HAL_UARTEx_RxEventCallback(UART_HandleTypeDef *huart, uint16_t Size) {}
```
