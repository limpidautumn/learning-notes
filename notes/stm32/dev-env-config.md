# 开发环境配置
STM32CubeMX + VSCode

[视频教程](https://www.bilibili.com/video/BV1QfbpzGENy/)

**思路：STM32CubeMX 生成环境，VSCode 编译烧录。**

## 系统
Windows / Linux

## 下载和安装 STM32CubeMX
[官网](https://www.st.com/en/development-tools/stm32cubemx.html)


## 配置 VSCode

新的 Profile

安装 [扩展插件](https://marketplace.visualstudio.com/items?itemName=stmicroelectronics.stm32-vscode-extension)，根据提示安装 Bundles。

## 试用

### 生成代码

打开 STM32CubeMX

File > New Project

如遇 `crdb.zip` 无法下载，参考 [该讨论](https://community.st.com/stm32cubemx-mcus-29/workaround-for-file-download-error-crdb-zip-problem-during-download-166762)。

选择芯片型号，下一步。

Pinout & Configuration > System Core > SYS: Debug: Serial Wire

Pinout & Configuration 设置 GPIO 模式及标签

Project Manager > Project > Project Settings > Project Name + Project Location

Project Manager > Project > Project Settings > Toolchain / IDE: CMake

Generate Code

### 编辑使用

VSCode 打开文件夹，切换 Profile。

根据提示，确认 `configure as STM32Cube project`。

编辑 `Core/Src/main.c`，实现 GPIO 功能。注意不要安装 `C/C++ Extension Pack`。

1. Build 后，可以从 `CMake 选项卡 > Build Analyzer` 中查看 RAM 和 Flash 占用情况。
2. 可以从 `Run and Debug 选项卡 > STM32Cube Devices and Boards` 中升级下载器固件。

开始 `Run and Debug`，选择 `STM32Cube: STM32 Launch STLink GDB Server`，开始调试。
