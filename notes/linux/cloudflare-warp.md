# Cloudflare WARP

[官方文档](https://developers.cloudflare.com/warp-client/get-started/linux/)

## 安装
### Debian/Ubuntu
```bash
curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg # 添加 GPG 密钥
echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list # 添加到 apt 软件源
sudo apt update && sudo apt install cloudflare-warp # 安装
```

## 使用
```bash
warp-cli --version
warp-cli --help
```

### 首次使用
```bash
warp-cli registration new # 注册与同意条款
warp-cli registration show # 查看注册信息
```

### 建立与断开连接
```bash
warp-cli connect # 建立连接
warp-cli status # 查看连接状态
curl https://www.cloudflare.com/cdn-cgi/trace # 验证 warp=on
warp-cli disconnect # 断开连接
```

### 设置运行模式
```bash
warp-cli mode --help # 各模式简介
warp-cli mode <mode-name> # 设置运行模式
warp-cli settings list | grep "Mode" # 查看当前模式
```
