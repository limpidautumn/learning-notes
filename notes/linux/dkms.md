# DKMS

Dynamic Kernel Module Support, 动态内核模块支持

[dkms-project/dkms - GitHub](https://github.com/dkms-project/dkms)

一个可以让内核模块在系统内核升级后自动重新编译的机制，安装树外 (out-of-tree) 模块时经常用到。

这里记录大致用法，做索引用；细节还需查看 manual。

## DKMS 自身, 安装方法

### Debian

```bash
sudo apt install dkms linux-headers-$(uname -r) linux-headers-$(dpkg --print-architecture)
```

1. `dkms`: DKMS 自身；
2. `linux-headers-$(uname -r)`: 当前正在运行的内核对应的头文件，编译内核模块时需要；
3. `linux-headers-$(dpkg --print-architecture)`: 元包，依赖当前系统最新可用的内核头文件，内核升级时需要。

### Ubuntu

```bash
sudo apt install dkms linux-headers-$(uname -r) linux-headers-generic
```

## 用法

### 查看 DKMS 管理的各模块状态

```bash
sudo dkms status
```

### 安装一个 DKMS 模块

模块源码通常放在 `/usr/src/mydriver-1.0/`。

配置文件 `dkms.conf`，用于明确：
- 模块包名；
- 模块版本号；
- 编译命令；
- 生成的每个 `.ko` 模块的名称、编译产物位置、安装目标位置……；
- 是否在内核更新时，自动编译安装；
- ……

注册模块：

```bash
sudo dkms add /usr/src/mydriver-1.0
```

构建内核模块：

```bash
sudo dkms build
```

安装模块：

```bash
sudo dkms install <PACKAGE_NAME>/<PACKAGE_VERSION>
```

### 卸载模块

```bash
sudo dkms remove <PACKAGE_NAME>/<PACKAGE_VERSION> --all
```

### Secure Boot 与 MOK 签名

检查 Secure Boot 是否启用：

```bash
mokutil --sb-state
```

若 UEFI BIOS 启用了 Secure Boot，UEFI 在启动时会验证引导程序、内核以及内核模块的数字签名。如果签名不受信任，就会拒绝启动或拒绝加载模块。Linux 自带的内核模块通常由发行版签名，所以能正常加载；但 DKMS 编译出来的第三方模块没有签名，会加载失败。

MOK (Machine Owner Key) 是机器所有者持有的一对密钥。公钥被加入 UEFI 固件的信任列表后，用私钥签名的内核模块就能被 Secure Boot 信任。

新版本的 DKMS 在第一次构建模块时，会在本机生成一套自签名的 MOK 密钥，并用它给编译出的 `.ko` 签名。

将公钥导入 MOK：

```bash
sudo mokutil --import /var/lib/dkms/mok.pub
# 要求输入一次性密码，会在稍后被用于验证身份。

sudo mokutil --list-new  # 确认待 enroll
sudo reboot  # 重启
```

重启时会出现蓝色 MokManager 界面，按 Enter, Esc 和上下键导航：

```text
Enroll MOK > View key > Continue > Yes > [Enter Password] > Reboot
```

检查签名：

```bash
mokutil --list-enrolled
sudo mokutil --test-key /var/lib/dkms/mok.pub
```
