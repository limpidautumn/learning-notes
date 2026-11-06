# 又犯错了

这不是 STM32 的某个外设。

这里记录我在做 STM32 开发时犯的错误。

- 2026-11-06T15:58:09+08:00 用 HAL_UART_Transmit_DMA 时，忘记开 USART2 global interrupt (USART2_IRQn)，导致 huart2.state 始终处于 BUSY_TX。
