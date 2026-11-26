# LXD

[LXD - Canonical](https://canonical.com/lxd) | [canonical/lxd - GitHub](https://github.com/canonical/lxd)

跟随 [Tutorial](https://canonical.com/lxd/docs/default/tutorial/first_steps/) 了解步骤，跟随 [Getting started](https://canonical.com/lxd/docs/default/getting_started/) 实现。

## 介绍

LXD 是一个系统容器与虚拟机管理器。

概念：
- `lxd`: LXD 守护进程，管理实例、存储、网络，提供 REST API；
- `lxc`: LXD 客户端；
- LXC: Linux 容器工具集，LXC ≠ LXD。

LXD 实例 (instance)：
- A. 系统容器 (container): 共享宿主机内核。与 Docker 不同，运行完整 Linux 用户空间。
- B. 虚拟机 (VM): 自带内核，完全隔离，依赖宿主机 KVM。

## 安装与配置

建议通过 [Snap](./snap.md) 安装。

```bash
sudo snap install lxd
```

### 安装后步骤

[Post-installation - Canonical LXD](https://canonical.com/lxd/docs/default/installing/#post-installation)

```bash
# 添加至用户组
getent group lxd | grep -qwF "$USER" || sudo usermod -aG lxd "$USER"
```

### 初始化

[How to initialize LXD - Canonical](https://canonical.com/lxd/docs/default/howto/initialize/)

在创建 LXD 实例之前，必须配置并初始化 LXD。

需要纳入考虑的几点：
1. UI 界面需要 “expose to network”。
2. 存储池: 单机推荐 ZFS，但是吃很多 RAM；Btrfs 仅容器，VM 不推荐。池可以扩，不可以缩。loop 文件开销稍大。

```bash
lxd init
```

不建议重复执行。

### 访问 UI 界面

[How to access the LXD web UI - Canonical](https://canonical.com/lxd/docs/default/howto/access_ui/) | [canonical/lxd-ui - GitHub](https://github.com/canonical/lxd-ui)

先确保 LXD server 向网络开放。

> [How to expose LXD to the network - Canonical](https://canonical.com/lxd/docs/default/howto/server_expose/)
> 
> ```bash
> lxc config set core.https_address :8443
> ```

具体地址：`ip a` 拿 ip 地址，`lxc config get core.https_address` 拿端口号。

#### 通过初始链接访问

生成新的初始链接：

```bash
lxd init --ui-initial-access-link
```

有效期一天。生成新链接时，旧链接权限会被撤回。

#### 使用浏览器证书授予永久访问权限

跟随 Web UI 指引逐步操作即可。

访问 Web UI，信任“不安全的连接”。选 TLS 方法，生成证书+私钥。导入操作系统/浏览器，重启浏览器。打开 Web UI，给证书。在终端建身份，取 token。在 Web UI 填 token，激活。

原理: 带外传递建立信任, mTLS 认证.

> **删除身份**
> 
> ```bash
> lxc auth identity list  # 列出服务器上所有已注册的身份
> # 假设需要删除的身份是 tls/lxd-ui
> # 也可使用 identifier, 例如 tls/919108f7-52d1-4320-9bac-f847db4148a8
> lxc auth identity show tls/lxd-ui  # 确认目标身份
> lxc auth identity delete tls/lxd-ui  # 删除身份
> ```

> **第二次身份认证**
> 
> 给的命令中，有一步：
> 
> ```bash
> lxc auth identity create tls/lxd-ui --group admins
> ```
> 
> 它不是幂等的。若想给新证书做认证，同时保留第一个证书：换名字。
> 
> ```bash
> lxc auth identity create tls/lxd-ui-2 --group admins
> ```


## 杂项

不知道放哪里的，或者暂时没写到那个阶段的，都放在这里。

**块设备扩容**

未实机验证。

LXD 不会监听底层块设备的大小变化。如使用块设备，分区扩容后需要显式向文件系统发出扩容命令。

```bash
# btrfs on LV
# 1. LVM 层扩容
lvextend -L +20G /dev/vg/lxdpool
# 2. 文件系统层扩容
btrfs filesystem resize max /var/snap/lxd/common/lxd/storage-pools/<pool>
# 3. 验证
lxc storage info <pool>

# ZFS on LV
# 1. LVM 层扩容
lvextend -L +20G /dev/vg/lxdpool
# 2. 文件系统层扩容
zpool online -e <zpool> /dev/vg/lxdpool
# 3. 验证
zpool list <zpool>
lxc storage info <pool>
```
