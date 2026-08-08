# Hyper-V 使用

已熟练掌握。

## 外设

### 磁盘
#### 挂载物理硬盘
先在 `Disk Management` 中 `offline`，再挂载到 Hyper-V 虚拟机中的 `SCSI Controller`。

#### 创建差分 VHDX 磁盘
在 File Explorer 中，将父 VHDX 设置为只读。

方法一：Hyper-V Manager 中，新建 Hard Disk，Disk Type 选择 Differencing。

方法二：PowerShell 命令。
```powershell
New-VHD -Path "C:\path\to\child.vhdx" -ParentPath "C:\path\to\parent.vhdx" -Differencing
Mount-VHD -Path "C:\path\to\child.vhdx" # 挂载差分磁盘
```

### Network Adapters / Virtual Switch
[视频](https://www.bilibili.com/video/BV1uQ4y1V77E/) | [Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/get-started/create-a-virtual-switch-for-hyper-v-virtual-machines)

#### 查看 vSwitch 信息
```powershell
Get-VMSwitch # 查看所有 vSwitch
Get-NetIPAddress -InterfaceAlias "vEthernet (<name of vSwitch>)" # 查看目标 vSwitch 的子网信息
```

#### [已弃用] 创建 NAT vSwitch
[Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/setup-nat-network)

vSwitch 作为 NAT 网关，为 VM 提供互联网服务。

先检查并清理已有 NAT 实例。

一个主机只允许创建一个 NAT，多个 NAT 运行会导致 Windows 系统进入未知状态。New-NetNat 命令没有防呆检测，所以需要先检查已有 NAT 实例。

```powershell
Get-NetNat | Remove-NetNat
```

假设子网为 192.168.137.0/24。

```powershell
New-VMSwitch -SwitchName "<name of vSwitch>" -SwitchType Internal # 创建 vSwitch，工作模式为 Internal
$ifIndex = (Get-NetAdapter -Name "vEthernet (<name of vSwitch>)").ifIndex # 获取索引，注意会变
New-NetIPAddress -IPAddress 192.168.137.1 -PrefixLength 24 -InterfaceIndex $ifIndex # 配置 NAT 网关 IP
New-NetNat -Name "<name of NAT>" -InternalIPInterfaceAddressPrefix 192.168.137.0/24 # 启用 NAT 转发规则
```

#### [已弃用] 查看 Hyper-V 虚拟机的子网 IP 地址
要求虚拟机安装了 Hyper-V 数据交换服务。

```powershell
Get-VM # 查看所有 VM
$vm = Get-VM -Name "<name of VM>" # 获取目标 VM
$vm.NetworkAdapters # 查看该 VM 的所有 Network Adapters
$adapter = $vm.NetworkAdapters | Where-Object { $_.SwitchName -eq "<name of vSwitch>" } # 筛选连接到 vSwitch 的 Adapter
$adapter.IPAddresses # 查看该 Adapter 获取到的所有 IP 地址
```

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

### Alpine Linux
- 生命周期：[发行](https://alpinelinux.org/releases/)
- 镜像站：[USTC](https://mirrors.ustc.edu.cn/alpine/) | [TUNA(THU)](https://mirrors.tuna.tsinghua.edu.cn/alpine/)

镜像选用 `alpine-virt-x.xx.x-x86_64.iso`，以安装在 Hyper-V 虚拟机中。
