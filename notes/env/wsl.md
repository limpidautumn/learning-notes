# WSL 安装与注销

```powershell
# 安装并启动 WSL 发行版
wsl --install -d Debian --name DIST_NAME
wsl -d DIST_NAME

# 注销 WSL 发行版
wsl --unregister DIST_NAME
```
