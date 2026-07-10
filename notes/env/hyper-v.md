# Hyper-V 使用

已熟练掌握。

### 镜像：Debian
- 生命周期：[发行](https://wiki.debian.org/DebianReleases) | [LTS](https://wiki.debian.org/LTS)
- 镜像站：[官方](https://cdimage.debian.org/) | [USTC](https://mirrors.ustc.edu.cn/debian-cd/current/) | [TUNA(THU)](https://mirrors.tuna.tsinghua.edu.cn/debian-cd/current/)

### 镜像：Ubuntu
- 生命周期：[发行](https://documentation.ubuntu.com/release-notes/)
- 镜像站：[官方](https://cdimage.ubuntu.com/)

### 镜像：Ubuntu Preinstalled
从 [镜像站](https://cdimage.ubuntu.com/ubuntu/releases/) **下载** 并 **解压** 对应版本的 `preinstalled server image`，得到 `.img` 磁盘镜像。

WSL 中，使用 QEMU 转换为 `.vhdx` 虚拟磁盘文件。
```bash
sudo apt update -y && sudo apt install -y qemu-utils
qemu-img convert -O vhdx ./ubuntu-26.04-preinstalled-server-amd64.img ./ubuntu-server-26.04.vhdx
```

创建虚拟机时选取副本作为系统盘即可。

默认用户名：`ubuntu`  
默认密码：`ubuntu`
