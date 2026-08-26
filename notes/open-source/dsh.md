# DeepSeek Harness

## 配置

### 安装
```bash
sudo npm install -g @deepseek-ai/dsh
```

### 开机自启
```bash
which dsh
which node
sudo vim /etc/systemd/system/dsh-web.service
```

```ini
[Unit]
Description=DeepSeek Harness Web Profile
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=current-user
Environment=PATH=/path/to/node/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ExecStart=/path/to/dsh web
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now dsh-web.service
```

#### 服务操作
```bash
sudo systemctl start dsh-web.service # 启动
sudo systemctl stop dsh-web.service # 停止
sudo systemctl restart dsh-web.service # 重启
```

### 自动更新

```bash
which npm
sudo vim /etc/systemd/system/dsh-update.service
```

```ini
[Unit]
Description=Update @deepseek-ai/dsh daily
Wants=network-online.target
After=network-online.target

[Service]
Type=oneshot
Environment=PATH=/path/to/node/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ExecStartPre=-/bin/systemctl stop dsh-web.service
ExecStart=npm update -g @deepseek-ai/dsh
ExecStartPost=-/bin/systemctl start dsh-web.service
```

```bash
sudo vim /etc/systemd/system/dsh-update.timer
```

```ini
[Unit]
Description=Run dsh update daily at 04:00

[Timer]
OnCalendar=*-*-* 04:00:00
Persistent=true
Unit=dsh-update.service

[Install]
WantedBy=timers.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now dsh-update.timer
```

#### 手动触发
```bash
sudo systemctl start dsh-update.service
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
