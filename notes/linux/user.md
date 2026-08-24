# Linux 用户

## 用户账号操作

### 创建用户
```bash
sudo useradd -m -s /bin/bash username # 同时创建家目录并指定登录 shell
```

### 添加/修改密码
```bash
passwd # 修改本用户的密码
sudo passwd <username> # 添加/修改目标用户的密码
sudo passwd -S <username> # 查看目标用户密码状态
sudo passwd -l <username> # 锁定目标用户的密码
```

### 删除用户
```bash
sudo userdel -r john # 同时删除家目录及邮件池
```

## sudo 权限

检查发行版默认的管理员组名。

```bash
sudo grep -E '^%(sudo|wheel|admin)' /etc/sudoers
```

### 赋予/收回 sudo 权限
#### 添加到管理员组以授权
```bash
sudo gpasswd -a <username> <groupname> # 添加到管理员组
sudo gpasswd -d <username> <groupname> # 从管理员组移除
```
重新登录生效。
#### 在 sudoers 文件中授权
```bash
sudo visudo
```
添加或移除行：
```
<username>  ALL=(ALL:ALL) ALL
```

### sudo 免密码

```bash
sudo visudo
```

打开 sudoers 文件，找到这一行：

```
%sudo   ALL=(ALL:ALL) ALL
```

将其改为：

```
%sudo   ALL=(ALL:ALL) NOPASSWD: ALL
```

