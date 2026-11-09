# uv

[文档](https://docs.astral.sh/uv/)


## 安装

### Linux / macOS

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Windows

```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

## 使用

### 虚拟环境

```bash
uv venv --python <version> # 创建虚拟环境

uv pip install torch requests
uv pip install -r requirements.txt

source .venv/bin/activate # 激活虚拟环境
deactivate # 退出当前激活的虚拟环境

# uv run 可以直接在虚拟环境中执行脚本或命令，无需手动激活
uv run python my_script.py
```

### 配置

[Configuration files - uv](https://docs.astral.sh/uv/concepts/configuration-files/)

项目配置文件: `pyproject.toml`

全局配置文件:
- Linux / macOS: `~/.config/uv/uv.toml`
- Windows: `%APPDATA%\uv\uv.toml`

配置层级: 命令行 > 环境变量 > 项目级 > 用户级 > 系统级.

#### PyPI 源

- 优先级: 同一配置文件中，越靠前优先级越高。
- 默认源: 兜底。始终视为最低优先级，与位置无关。默认 PyPI，可覆写。

全局配置:

```toml
[[index]]
name = "ustc"
url = "https://mirrors.ustc.edu.cn/pypi/simple/"

[[index]]
name = "tuna"
url = "https://pypi.tuna.tsinghua.edu.cn/simple"
# default = true  # 覆写默认源
```

项目配置:

```toml
[[tool.uv.index]]
# ... 其余同上
```

### uv tool

```bash
# 安装一个 Python CLI 工具
uv tool install [OPTIONS] <PACKAGE>

uv tool install paddleocr  # 安装工具
uv tool list  # 查看已安装的工具
uv tool upgrade paddleocr  # 升级工具
uv tool uninstall paddleocr  # 卸载工具
```
