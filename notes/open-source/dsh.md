# DeepSeek Harness

## 本机配置

### 安装
```bash
npm install -g @deepseek-ai/dsh
sudo vim /etc/systemd/system/dsh-web.service
```

### 后台任务

```ini
[Unit]
Description=DeepSeek Harness Web Profile
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=<USERNAME>
ExecStart=/bin/bash -ic 'cd ~; exec dsh --profile web --no-open'
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now dsh-web.service
```

### 环境变量

[packages/util/launch-environment/README.zh.md](https://github.com/deepseek-ai/deepseek-harness/blob/master/packages/util/launch-environment/README.zh.md)

优先级: 继承的进程环境 > `<invocation cwd>/.env` > `$DSH_HOME/.env`.

### 代理

[docs/user/guide/network-proxy.zh.md](https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/user/guide/network-proxy.zh.md)

为 DSH 进程配置标准代理环境变量即可。支持 HTTP/HTTPS 代理，不支持 SOCKS5。

```dotenv
HTTPS_PROXY=http://127.0.0.1:40000
HTTP_PROXY=http://127.0.0.1:40000
NO_PROXY=internal.example.com
```

- 对 HTTP 请求：HTTP_PROXY > ALL_PROXY
- 对 HTTPS 请求：HTTPS_PROXY > ALL_PROXY > HTTP_PROXY
- 直连 (NO_PROXY)：
  1. 不需要列出 localhost 或 127.0.0.1
  2. CIDR 网段不生效，改用主机名或域名后缀

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

# --- Personalization ---

# DeepSeek-Balance-Whale-Widget from dsh-market by MeteorNOX

```

## 杂项
### API Key 验证 (DeepSeek)
用于检查某个 DeepSeek API Key 是否有效。
```bash
DEEPSEEK_API_KEY="sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
curl -fsS -H "Authorization: Bearer $DEEPSEEK_API_KEY" https://api.deepseek.com/models
```
