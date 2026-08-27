# uv

[文档](https://docs.astral.sh/uv/)


## 安装

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
``` 

## 使用

```bash
uv venv --python <version> # 创建虚拟环境

uv pip install torch requests
uv pip install -r requirements.txt

source .venv/bin/activate # 激活虚拟环境
deactivate # 退出当前激活的虚拟环境

# uv run 可以直接在虚拟环境中执行脚本或命令，无需手动激活
uv run python my_script.py
```
