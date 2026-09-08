# STM32CubeMX

Linux

[User Manual](https://www.st.com/resource/en/user_manual/dm00104712-stm32cubemx-for-stm32-configuration-and-initialization-c-code-generation-stmicroelectronics.pdf)

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
