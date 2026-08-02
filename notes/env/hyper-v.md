# Hyper-V 使用

已熟练掌握。

## 外设

### Network Adapters / Virtual Switch
[视频](https://www.bilibili.com/video/BV1uQ4y1V77E/) | [Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/setup-nat-network)

#### 查看 Hyper-V 虚拟机的子网 IP 地址
要求虚拟机安装了 Hyper-V 数据交换服务。

```powershell
Get-VMSwitch # 查看所有 vSwitch
Get-NetIPAddress -InterfaceAlias "vEthernet (<name of vSwitch>)" # 查看目标 vSwitch 的子网信息
Get-VM # 查看所有 VM
$vm = Get-VM -Name "<name of VM>" # 获取目标 VM
$vm.NetworkAdapters # 查看该 VM 的所有 Network Adapters
$adapter = $vm.NetworkAdapters | Where-Object { $_.SwitchName -eq "<name of vSwitch>" } # 筛选连接到 vSwitch 的 Adapter
$adapter.IPAddresses # 查看该 Adapter 获取到的所有 IP 地址
```

平时没啥用。

## 常用系统

### Debian
- 生命周期：[发行](https://wiki.debian.org/DebianReleases) | [LTS](https://wiki.debian.org/LTS)
- 镜像站：[官方](https://cdimage.debian.org/) | [USTC](https://mirrors.ustc.edu.cn/debian-cd/current/) | [TUNA(THU)](https://mirrors.tuna.tsinghua.edu.cn/debian-cd/current/)

### Ubuntu
- 生命周期：[发行](https://documentation.ubuntu.com/release-notes/)
- 镜像站：[官方](https://cdimage.ubuntu.com/)

### Ubuntu Server Preinstalled
从 [镜像站](https://cdimage.ubuntu.com/ubuntu/releases/) **下载** 并 **解压** 对应版本的 `preinstalled server image`，得到 `.img` 磁盘镜像。

WSL 中，使用 QEMU 转换为 `.vhdx` 虚拟磁盘文件。
```bash
sudo apt update -y && sudo apt install -y qemu-utils
qemu-img convert -O vhdx ./ubuntu-26.04-preinstalled-server-amd64.img ./ubuntu-server-26.04.vhdx
```

创建虚拟机时选取副本作为系统盘即可。

默认用户名：`ubuntu`  
默认密码：`ubuntu`

动态内存预留改 30%，默认值会导致内核不久后崩溃。
