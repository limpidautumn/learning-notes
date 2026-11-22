# 随记：Nvidia 驱动安装

网上已经有很多教程了，官方文档也相当详细。

[Driver Installation Guide - NVIDIA Corporation](https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/latest/pdf/Driver_Installation_Guide.pdf)

## Debian

[Debian - NVIDIA Driver Installation Guide](https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/latest/debian.html) | [Pre-installation Actions](https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/latest/pre-installation-actions.html)

```bash
hostnamectl
```

以 amd64 架构、`Debian GNU/Linux 13 (trixie)` 系统 (debian13/x86_64) 为例，配置软件源。

先清理旧驱动，过程略。

准备内核头文件和 contrib 组件：

```bash
sudo apt install linux-headers-$(uname -r) linux-headers-amd64
cat /etc/apt/sources.list.d/debian.sources  # 检查 contrib 组件
# sudo add-apt-repository contrib  # 启用 contrib 组件
```

安装 `cuda-keyring` 包：

```bash
wget https://developer.download.nvidia.com/compute/cuda/repos/debian13/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
rm cuda-keyring_1.1-1_all.deb

sudo apt update
```

> 对于下面的手动 keyring 步骤：
> 
> > 注册签名密钥：
> > 
> > ```bash
> > sudo wget -O /usr/share/keyrings/cuda-archive-keyring.gpg 
> > ```
> > 
> > 启用网络软件仓库：
> > 
> > ```bash
> > echo "deb [signed-by=/usr/share/keyrings/cuda-archive-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/debian13/x86_64/ /" | sudo tee /etc/apt/sources.list.d/cuda-debian13-x86_64.list
> > ```
> 
> 实测发现 <https://developer.download.nvidia.com/compute/cuda/repos/debian13/x86_64/cuda-archive-keyring.gpg> 不存在。
> 
> NVIDIA 当前 debian13 仓库不再单独发布 `cuda-archive-keyring.gpg`，故优先用 `cuda-keyring` 包。

安装驱动：

```bash
sudo apt --verbose-versions install nvidia-open
```

若 Secure Boot 开启，DKMS 编译出的模块需要签 MOK。具体方法，见 [DKMS 中的 MOK 一节](../notes/linux/dkms.md#secure-boot-与-mok-签名)。
