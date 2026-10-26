# CMake

<https://cmake.org/> | <https://gitlab.kitware.com/cmake/cmake>

[GitHub](https://github.com/Kitware/CMake/releases)

## 安装

Ubuntu 可以选择用 [官方 apt 源](https://apt.kitware.com/)。部分发行版的 CMake 很新。其他 Linux 发行版只能下载编译二进制、从源码构建或者用自带的版本偏旧的 CMake。

## 使用

CMakeLists.txt

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
