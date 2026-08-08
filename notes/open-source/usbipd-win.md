# usbipd-win

作为 **服务端**，通过 TCP/IP 共享（连接到本机的）USB 设备。

[GitHub](https://github.com/dorssel/usbipd-win)

usbipd-win 5.3.0

## 安装
```powershell
winget install usbipd
```

## 服务端控制
### 共享 USB 设备
管理员身份运行：
```powershell
usbipd list
usbipd bind --busid=<BUSID>
```
持久的，重启后保持共享。

### 取消共享
```powershell
usbipd unbind --busid=<BUSID>
```

### 其它功能
等用得到时再研究。

| Command | Description | 简介 |
| :--: | :--: | :--: |
| server | Run the server on the console | 在前台运行服务 |
| state | Output state in JSON | 以 JSON 格式输出当前状态 |
| policy | Manage policy rules | 管理策略规则 |

## 客户端控制
### 其它 Linux
见 [相关笔记](../linux/usbip.md)。
### WSL 2
```powershell
usbipd attach --wsl --busid=<BUSID>
usbipd detach --busid=<BUSID>
```
