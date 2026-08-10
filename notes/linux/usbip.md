# usbip

通过网络共享 USB 设备。

## 安装

### 内核部分
一般已内置，只是可能没有被自动加载。
```bash
lsmod | grep usbip # 检查加载情况
sudo modprobe usbip-core
sudo modprobe usbip-host
sudo modprobe vhci-hcd # 客户端
```

### 用户空间工具
```bash
sudo apt install usbip # 或 linux-tools-generic linux-tools-$(uname -r)，Debian / Ubuntu
```

## 使用

```bash
man usbip
```

**注意**：
- 所有命令通常需要 `root` 权限。
- 服务端需运行 `usbipd` 守护进程。

### 作为服务端
```bash
usbip list -l # 查看本地 USB 设备
usbip bind -b <busid> # 绑定设备（使其可被远程访问）
# 绑定后，设备不再被本地驱动使用，仅供远程客户端连接。
usbip unbind -b <busid> # 解绑设备（恢复本地使用）
# 停止导出，设备重新由本地驱动接管。
```

### 作为客户端
```bash
modprobe vhci-hcd # 加载内核模块：创建虚拟 USB 主机控制器，需要手动加载
usbip list -r <server-ip> [--tcp-port=<tcp-port>] # 查看远程可用的设备
usbip attach -r <server-ip> [--tcp-port=<tcp-port>] -b <busid> # 连接远程设备
usbip port # 查看已导入的设备
usbip detach -p <port> # 断开设备
```
