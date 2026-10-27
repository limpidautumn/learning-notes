# CMake

<https://cmake.org/> | <https://gitlab.kitware.com/cmake/cmake>

[GitHub](https://github.com/Kitware/CMake/releases)

[CMake Reference Documentation](https://cmake.org/cmake/help/latest/)

## 安装

Ubuntu 可以选择用 [官方 apt 源](https://apt.kitware.com/)。部分发行版的 CMake 很新。其他 Linux 发行版只能下载编译二进制、从源码构建或者用自带的版本偏旧的 CMake。

## 使用

### 配置/构建

```bash
cmake -S . -B build  # 以当前目录为源码目录，配置到 build 目录
cmake --build build  # 在 build 目录中执行构建
```

### CML

CMakeLists.txt 是 CMake 构建系统的配置文件，用于描述如何编译和链接项目。

```cmake
# 第一条命令：兼容性保障。
cmake_minimum_required(VERSION 3.10)
# 高版本 CMake 会保证运行方式相同。

# 第二条命令：设置项目名称。
project(MyProject [VERSION 1.0.0] [LANGUAGES CXX])
# [...] 可选
# 项目名称会被存储到变量 PROJECT_NAME 中。从顶层调用时，同时存储到变量 CMAKE_PROJECT_NAME 中。
# 配置 PROJECT_SOURCE_DIR, PROJECT_BINARY_DIR 等变量。

# 添加一个名为 <name> 的可执行目标 (executable target)。
add_executable(<name>)

# Target Build Specification 目标构建规格

# scope: 描述依赖的传递边界
# - PRIVATE: 填

# target_* 命令

# 将源文件添加到目标中。
target_sources(<target> {INTERFACE|PUBLIC|PRIVATE} <source>...)
```

## 格式化方法

### cmake-format

[cheshirekow/cmake_format - GitHub](https://github.com/cheshirekow/cmake_format) | [cmakelang - pypi](https://pypi.org/project/cmakelang/)

[cheshirekow.cmake-format - VSCode Extension](https://marketplace.visualstudio.com/items?itemName=cheshirekow.cmake-format)

是很老的项目。

### gersemi
[BlankSpruce/gersemi - GitHub](https://github.com/BlankSpruce/gersemi)

```bash
# 安装
pip3 install gersemi
uv tool install gersemi  # 如果使用 uv

# 使用方法
gersemi --check .  # 检查需要重新格式化的文件
gersemi --in-place .  # 原地格式化
```

配置文件：`.gersemirc`  
优先级: 命令行参数 > 由近及远的配置文件 > 默认值  
示例：[.gersemirc.example](https://github.com/BlankSpruce/gersemi/blob/master/.gersemirc.example)

```yaml
indent: 2
unsafe: false
```

### cmakefmt
[cmakefmt/cmakefmt - GitHub](https://github.com/cmakefmt/cmakefmt)
