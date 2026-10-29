# CMake

<https://cmake.org/> | <https://gitlab.kitware.com/cmake/cmake>

[GitHub](https://github.com/Kitware/CMake/releases)

[CMake Reference Documentation](https://cmake.org/cmake/help/latest/)

## 安装

Ubuntu 可以选择用 [官方 apt 源](https://apt.kitware.com/)。部分发行版的 CMake 很新。其他 Linux 发行版只能下载编译二进制、从源码构建或者用自带的版本偏旧的 CMake。

## 使用

只记常用用法，准确内容请参考官方文档。

笔记是在 latest == 4.5.0-rc1 写的，没有记录新用法。

### 配置/构建

```bash
cmake -S . -B build  # 以当前目录为源码目录，配置到 build 目录
cmake --build build  # 在 build 目录中执行构建
```

### CML

CMakeLists.txt 是 CMake 构建系统的配置文件，用于描述如何编译和链接项目。

```cmake
# 第一条命令：兼容性保障。
cmake_minimum_required(VERSION 3.16)
# 高版本 CMake 会保证运行方式相同。

# 第二条命令：设置项目名称。
project(MyProject [VERSION 1.0.0] [LANGUAGES CXX])
# [...] 可选
# 项目名称会被存储到变量 PROJECT_NAME 中。从顶层调用时，同时存储到变量 CMAKE_PROJECT_NAME 中。
# 配置 PROJECT_SOURCE_DIR, PROJECT_BINARY_DIR 等变量。

# 配置普通变量
set(<variable> <value>)

# 添加一个名为 <name> 的可执行目标 (executable target)。
add_executable(<name>)

# 添加一个名为 <name> 的库目标 (library target)。
add_library(<name> [<type>] <source>...)
# <type> 未指定时，默认类型受 BUILD_SHARED_LIBS 控制。
# 自 CMake 3.11 起，<source> 可被省略，稍后用 target_sources() 添加。

# 向指定目标添加源文件。
target_sources(<target> <scope> <source>...)

# 为目标指定编译时使用的头文件搜索目录
target_include_directories(<target> <scope> <dir>...)

# 为目标添加链接时要用的库。
target_link_libraries(<target> <scope> <item>...)

# 向当前构建中添加一个子目录。
add_subdirectory(<source_dir>)
# CMake 会进入指定的子目录，读取并处理其中的 CMakeLists.txt，从而把该子目录中的目标纳入整个构建系统。

# 声明目标编译时需要编译器支持哪些语言特性。
target_compile_features(<target> <scope> <feature>...)
# CMAKE_CXX_COMPILE_FEATURES: cxx_std_98/11/14/17/20/23/26

# 为目标添加编译选项。
target_compile_options(<target> <scope> <item>...)

# 为目标添加编译定义。
target_compile_definitions(<target> <scope> <definition>...)

# 为 (可执行、共享库或模块库) 目标添加链接步骤的选项，CMake 3.13 引入。
target_link_options(<target> <scope> <item>...)

```

#### 内置变量

- [`CMAKE_SOURCE_DIR`](https://cmake.org/cmake/help/latest/variable/CMAKE_SOURCE_DIR.html): 当前 CMake 源码树的顶层目录的完整路径，即项目最外层 CMakeLists.txt 所在的源码目录。
- [`CMAKE_CURRENT_SOURCE_DIR`](https://cmake.org/cmake/help/latest/variable/CMAKE_CURRENT_SOURCE_DIR.html): 当前正在被 CMake 处理的源码目录的完整路径。
- [`PROJECT_NAME`](https://cmake.org/cmake/help/latest/variable/PROJECT_NAME.html): 当前目录作用域中最近一次 `project()` 调用所指定的项目名。

#### 配置变量

- [`BUILD_SHARED_LIBS`](https://cmake.org/cmake/help/latest/variable/BUILD_SHARED_LIBS.html): 控制 `add_library()` 在未显式指定库类型时的默认行为。为 TRUE 时，默认生成动态库 (SHARED)；为 FALSE 或未定义时，默认生成静态库 (STATIC)。
- [`CMAKE_EXPORT_COMPILE_COMMANDS`](https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html): 控制在生成构建系统时是否输出编译数据库文件 `${CMAKE_BINARY_DIR}/compile_commands.json`，为 TRUE 时生成。
- [`CMAKE_CXX_EXTENSIONS`](https://cmake.org/cmake/help/latest/variable/CMAKE_CXX_EXTENSIONS.html)：控制是否开启编译器扩展，为 FALSE 时使用严格标准模式。

#### Scope

[Target Commands - cmake-buildsystem(7) - CMake Documentation](https://cmake.org/cmake/help/latest/manual/cmake-buildsystem.7.html#target-commands)

**概念**

`target_*` 系列命令中，`PUBLIC`、`PRIVATE`、`INTERFACE` 控制参数的作用范围 (scope)。

| 关键字</br>Scopes | 对自身目标的构建</br>Build Specification | 对消费者的使用要求</br>Usage Requirements |
| :--- | :--- | :--- |
| `PUBLIC` | ☒ 填充 | ☒ 填充 |
| `PRIVATE` | ☒ 填充 | ☐ 不填充 |
| `INTERFACE` | ☐ 不填充 | ☒ 填充 |

**原理**

本质上，每个 `target_*` 命令操作一对属性：构建属性和使用要求属性。例如 `target_compile_options()` 对应 `COMPILE_OPTIONS` 和 `INTERFACE_COMPILE_OPTIONS`。命令被执行时，指定的内容会被追加到对应属性。

Scope 明确命令需要写哪些属性。
- `PRIVATE`: 只写不带前缀的 `*` 属性；
- `INTERFACE`: 只写 `INTERFACE_*` 属性；
- `PUBLIC`: 两者都写。

使用要求通过 `target_link_libraries()` 沿着依赖链传播，规则是：依赖的 `INTERFACE_*` 属性追加到消费者的 `*` 属性。

**使用方法**

如果正在制作某个应用程序，全部写 PRIVATE。

如果正在制作某个库：
- 仅被库的源文件使用，例如内部实现：用 `PRIVATE`。
- 被源文件及头文件使用，例如公共 API 接口：用 `PUBLIC`
- 仅被头文件使用，例如 header-only 库：用 `INTERFACE`。

#### 杂项

未归类。

- 在 CMake 中，路径要么是绝对路径，要么是相对 `CMAKE_CURRENT_SOURCE_DIR` 的相对路径。
- 目录作用域规则。

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
