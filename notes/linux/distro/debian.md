# Debian

## 系统配置

### 下载源

#### 传统方法

```bash
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo vim /etc/apt/sources.list
```

安装器一般写到这里。

#### 片段文件 (deb822, Debian 6.0+)

`.sources` 是 deb822 格式软件源文件。由多个段落组成，段落之间用空行分隔。每个段落用若干 `字段: 值` 描述一个软件源。多值字段用空格分隔。

停用旧源，避免重复。

```bash
sudo mv /etc/apt/sourecs.list{,.disabled}
```

确认版本：

```bash
cat /etc/os-release
```

下面以 Debian 13 (trixie) 为例

**官方源**

```bash
sudo vim /etc/apt/sources.list.d/debian.sources
```

```text
Types: deb
URIs: https://deb.debian.org/debian
Suites: trixie trixie-updates
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb
URIs: https://security.debian.org/debian-security
Suites: trixie-security
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
```

**镜像源**

```bash
sudo vim /etc/apt/sources.list.d/debian.sources
```

```text
Types: deb
URIs: https://mirrors.ustc.edu.cn/debian/
Suites: trixie trixie-updates
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb
URIs: https://mirrors.ustc.edu.cn/debian-security/
Suites: trixie-security
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
```

## Debian Backports

[backports.debian.org](https://backports.debian.org/)

[Instructions - Debian Backports](https://backports.debian.org/Instructions/)

```bash
sudo vim /etc/apt/sources.list.d/backports.sources
```

```text
Types: deb deb-src
URIs: http://deb.debian.org/debian
Suites: trixie-backports
Components: main
Enabled: yes
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
```
