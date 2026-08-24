# I2C 通信

## CubeMX 配置

### I2C
Pinout & Configuration > Connectivity > I2C1 / I2C2

开启中断：NVIC Settings > I2CX event / error interrupt: Add [x]

开启 DMA：DMA Settings > Add

### 代码生成
对每个外设生成对应 .c/.h 文件用于初始化，以便于管理。

Project Manager > Code Generator > Generated files > [x] Generate peripheral initialization as a pair of '.c/.h' files per peripheral

## HAL 库调用
作为主机
```c
// DMA 发送
HAL_I2C_Master_Receive_DMA(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size);
void HAL_I2C_MasterRxCpltCallback(I2C_HandleTypeDef *hi2c);

// DMA 接收
HAL_I2C_Master_Transmit_DMA(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size);
void HAL_I2C_MasterTxCpltCallback(I2C_HandleTypeDef *hi2c);
```
