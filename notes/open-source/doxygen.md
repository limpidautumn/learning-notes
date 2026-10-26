# doxygen

[Website](https://www.doxygen.org/) | [GitHub](https://github.com/doxygen/doxygen)

## 安装

### 从预编译静态二进制包

#### 安装

以 1.18.0 为例，最新版本见 Release / Changelog。

```bash
cd /tmp
curl -LO https://github.com/doxygen/doxygen/releases/download/Release_1_18_0/doxygen-1.18.0.linux.bin.tar.gz
tar -xzf doxygen-1.18.0.linux.bin.tar.gz
ls doxygen-1.18.0
sudo mv doxygen-1.18.0 /opt/
sudo ln -sf /opt/doxygen-1.18.0/bin/doxygen /usr/local/bin/doxygen
```

#### 卸载

```bash
sudo rm -rf /opt/doxygen-1.18.0
sudo rm -f /usr/local/bin/doxygen
```

### DOT
Doxygen 需要 Graphviz 渲染图表。
```bash
sudo apt install graphviz
```

## 使用

### 生成 Doxyfile 模板

```bash
doxygen -g  // 将模板写入 ./Doxyfile
```

### 编辑 Doxyfile 配置

```txt
PROJECT_NAME = "My Project"  # 项目名称
PROJECT_NUMBER = 0.0.0  # 版本号
PROJECT_BRIEF = "My Project Brief"  # 项目简介

OUTPUT_DIRECTORY = docs  # 输出路径

INPUT = src include README.md  # 源文件或目录列表
RECURSIVE = YES  # 子目录
USE_MDFILE_AS_MAINPAGE = README.md  # 主页面

WARN_AS_ERROR = YES  # 严格检查
SOURCE_BROWSER = YES  # 源码预览
HAVE_DOT = YES  # 图表

...
```

### 运行 Doxygen

```bash
doxygen  // 根据 Doxyfile 生成文档
```

### 查看输出

```bash
python3 -m http.server 8000 -d docs/html
```
