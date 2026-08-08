# usbip

通过网络共享 USB 设备。

```bash
man usbip
```

**注意**：
- 所有命令通常需要 `root` 权限。
- 服务端需运行 `usbipd` 守护进程。

## 作为服务端
```bash
usbip list --local # 查看本地 USB 设备
usbip bind --busid=1-2 # 绑定设备（使其可被远程访问）
# 绑定后，设备不再被本地驱动使用，仅供远程客户端连接。
usbip unbind --busid=1-2 # 解绑设备（恢复本地使用）
# 停止导出，设备重新由本地驱动接管。
```

## 作为客户端
```bash
modprobe vhci-hcd # 加载内核模块：创建虚拟 USB 主机控制器，需要手动加载
usbip list --remote=<server-ip> [--tcp-port=<tcp-port>] # 查看远程可用的设备
usbip attach --remote=<server-ip> [--tcp-port=<tcp-port>] --busid=<busid> # 连接远程设备
usbip port # 查看已导入的设备
usbip detach --port=<port> # 断开设备
```
