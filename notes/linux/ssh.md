# SSH

已熟练掌握

[OpenBSD Manual: ssh](https://man.openbsd.org/ssh) | [OpenBSD Manual: sshd](https://man.openbsd.org/sshd) | [OpenBSD Manual: sshd_config](https://man.openbsd.org/sshd_config)

```bash
ssh-keygen
ssh-copy-id -i ~/.ssh/id_xxx.pub [user@]host[:port]
sudo sshd -T # 生效的规则
```

### 分发公钥
#### 常规
```bash
ssh-copy-id -i ~/.ssh/id_xxx.pub [user@]host[:port]
```
#### 手动
[OpenBSD Manual: sshd - AUTHORIZED_KEYS FILE FORMAT](https://man.openbsd.org/sshd#AUTHORIZED_KEYS_FILE_FORMAT)

```bash
mkdir -p ~/.ssh/
sudo vim ~/.ssh/authorized_keys
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
