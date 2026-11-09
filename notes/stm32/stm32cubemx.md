# STM32CubeMX

Linux

[UM1718: STM32CubeMX for STM32 configuration and initialization C code generation - STMicroelectronics](https://www.st.com/resource/en/user_manual/um1718-stm32cubemx-for-stm32-configuration-and-initialization-c-code-generation-stmicroelectronics.pdf)

## 安装

从 [官网](https://www.st.com/en/development-tools/stm32cubemx.html) 下载安装包。
```bash
unzip SetupSTM32CubeMX-xxx.zip
sudo ./SetupSTM32CubeMX-xxx
```

手动创建 [`.desktop` 文件](../../notes/linux/desktop.md)：
```ini
[Desktop Entry]
Type=Application
Name=STM32CubeMX
Exec=/usr/local/STMicroelectronics/STM32Cube/STM32CubeMX/STM32CubeMX
Icon=/usr/local/STMicroelectronics/STM32Cube/STM32CubeMX/help/STM32CubeMX.png
Terminal=false
Categories=Development;
```

## Bug

记录我遇到的 STM32CubeMX 的 Bug。

懒得报告了。在这里记一下，避免重复查手册确认。

1. Version 6.18.1, STM32F103C8Tx, Timers > TIM2. Mode: Slave Mode = External Clock Mode 1, Trigger Source = TI1FP1. Configuration > Parameter Settings > Trigger > Trigger Polarity: Rising Edge, Falling Edge, Both Edges. The "Both Edges" option should not appear here. Testing reveals that only a single edge is captured.
