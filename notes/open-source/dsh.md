# DeepSeek Harness

## 本机配置

### 安装
```bash
npm install -g @deepseek-ai/dsh
mkdir -p ~/.config/systemd/user/
vim ~/.config/systemd/user/dsh-web.service
```

```ini
[Unit]
Description=DeepSeek Harness Web Profile
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
ExecStart=/bin/bash -ic 'cd ~; exec dsh --profile web --no-open'
Restart=on-failure
RestartSec=5
```

```bash
systemctl --user daemon-reload
```

## 插件

```bash
# dsh-tui
npm install -g @deepseek-harness-tui/dsh-tui
# usage: dsh-tui

# dsh-market / awesome-dsh-plugin
dsh plugin --profile web add dshmarket

# --- Information Visualization ---

# dsh-context from dsh-market by bowenliang123
# dsh-archive-manager from dsh-market by MichengAI

# --- Performance Improvement ---

# graph-memory

# --- Personalization ---

# DeepSeek-Balance-Whale-Widget from dsh-market by MeteorNOX

```

## 杂项
### API Key 验证 (DeepSeek)
用于检查某个 DeepSeek API Key 是否有效。
```bash
TOKEN="sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
curl -fsS -H "Authorization: Bearer $TOKEN" https://api.deepseek.com/models
```
