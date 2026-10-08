# DeepSeek Harness

## 本机配置

### 安装
```bash
npm install -g @deepseek-ai/dsh

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

## 插件

```bash
# dsh-market / awesome-dsh-plugin
dsh plugin --profile web add dshmarket

# --- Information Visualization ---

# dsh-context from dsh-market by bowenliang123
# dsh-archive-manager from dsh-market by MichengAI

# --- Performance Improvement ---

# dsh-routing-suite
# https://github.com/yjh051108/dsh-routing-suite
# 没有安装的好办法，只能一步一步走。

# graph-memory

# --- Personalization ---

# whale-girl from dsh-market by vlln

# skin-center
dsh plugin --profile web add @linxin666/dsh-client-ui-skin-center

# DeepSeek-Balance-Whale-Widget from dsh-market by MeteorNOX

```

## 杂项
### API Key 验证 (DeepSeek)
用于检查某个 DeepSeek API Key 是否有效。
```bash
TOKEN="sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
curl -fsS -H "Authorization: Bearer $TOKEN" https://api.deepseek.com/models
```
