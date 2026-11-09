# SSH

已熟练掌握

[ssh - OpenBSD](https://man.openbsd.org/ssh) | [ssh_config - OpenBSD](https://man.openbsd.org/ssh_config) | [sshd - OpenBSD](https://man.openbsd.org/sshd) | [sshd_config - OpenBSD](https://man.openbsd.org/sshd_config)

```bash
ssh-keygen
ssh-copy-id -i ~/.ssh/id_xxx.pub [user@]host[:port]
sudo sshd -T # 生效的规则
```

## 用法

### ssh 客户端配置文件

[ssh_config - OpenBSD Manual](https://man.openbsd.org/ssh_config)

命令行选项 > 用户配置文件 `~/.ssh/config` > 系统配置文件 `/etc/ssh/ssh_config`

### 分发公钥
#### 常规
```bash
ssh-copy-id -i ~/.ssh/id_xxx.pub [user@]host[:port]
```
#### 手动
[AUTHORIZED_KEYS FILE FORMAT - sshd, OpenBSD Manual](https://man.openbsd.org/sshd#AUTHORIZED_KEYS_FILE_FORMAT)

```bash
mkdir -p ~/.ssh/
vim ~/.ssh/authorized_keys
```

格式：`[options] keytype key comment`，注释用 `#`。

手动创建时需注意权限：
- `~/.ssh` 权限 `700`；
- `~/.ssh/authorized_keys` 权限 `600`。

### 禁用密码登录

#### 常规方法
在 `/etc/ssh/sshd_config` 中配置：
```conf
PasswordAuthentication no
# ChallengeResponseAuthentication no # deprecated, 可选
# KbdInteractiveAuthentication no # 可选
```

```bash
sudo sshd -t
sudo systemctl restart ssh
sudo sshd -T | grep "PasswordAuthentication" # 检查生效
```

#### 配置片段 (OpenSSH 8.2+)
```bash
ls /etc/ssh/sshd_config.d/ # 查看已有片段
sudo vim /etc/ssh/sshd_config.d/01-sshcfg.conf
```

```conf
PasswordAuthentication no
```

```bash
ls -la /etc/ssh/sshd_config.d/ # 权限 644 及以上
sudo sshd -t # 测试语法
sudo systemctl restart ssh
```

### 跳板机转发
```bash
ssh -J [user@]jump_host_1[:port][,[user@]jump_host_2[:port],...] [user@]target_host[:port]
```

本机需拥有所有机器凭据，跳板机无需存放目标机或下一跳凭据。

跳板机需要在 `/etc/ssh/sshd_config` 中有配置：
```
AllowTcpForwarding yes
```

### 本地端口转发
```bash
ssh -N -L port_2:127.0.0.1:port_1 user@host
```

将服务器上的 port_1 端口转发到本机的 port_2 端口，常配合 `-N` (不执行远程命令) 使用。

VSCode 上的 `Remote - SSH` 插件自带该功能。入口位于 Status Bar。

### X11 转发
```conf
X11Forwarding yes
```

```bash
ssh -X user@host
```

### 代理

[ProxyCommand - ssh_config, OpenBSD Manual](https://man.openbsd.org/ssh_config#ProxyCommand)

> **ProxyCommand**
> 
> ... The command can be basically anything, and should read from its standard input and write to its standard output. It should eventually connect an sshd(8) server running on some machine, or execute sshd -i somewhere. ...

假设代理运行在 127.0.0.1:40000，需要穿过代理访问 github.com。

先检查并安装 OpenBSD 版的 netcat。

```bash
# 检查本机 nc 版本:
nc -h 2>&1 | head -1  # 有无 OpenBSD 字样

# 若为 netcat-traditional, 则需安装 netcat-openbsd:
sudo apt install netcat-openbsd
```

然后写配置文件 `~/.ssh/config`。

```conf
Host github.com
    ProxyCommand nc -X 5 -x 127.0.0.1:40000 %h %p
```

> **解释**
> 
> ```text
> nc [-X proxy_protocol] [-x proxy_address[:port]] [destination] [port]
> ```
> 
> 通过指定的代理服务器连接目标主机的指定端口。
> 
> - `-x addr[:port]`: 代理服务器地址和端口
> - `-X 5`: 使用 SOCKS5 协议
> - `%h`: ssh 占位符，展开为目标主机名
> - `%p`: ssh 占位符，展开为目标端口
> 
> 流程: ssh 客户端使用管道连接 Netcat，通过代理服务器向目标主机建立 TCP 连接。
