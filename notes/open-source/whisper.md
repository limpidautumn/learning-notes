# OpenAI Whisper 部署记录
[GitHub](https://github.com/openai/whisper)

```bash
cd ~
sudo apt update -y

# 安装 uv
sudo apt install curl -y
curl -LsSf https://astral.sh/uv/install.sh | sh
sudo reboot

# 配置虚拟环境
uv venv
source .venv/bin/activate

# 安装依赖
uv pip install openai-whisper
sudo apt install ffmpeg -y

# 音频转写
whisper AUDIO_FILE --language zh

# 退出虚拟环境
deactivate
```
