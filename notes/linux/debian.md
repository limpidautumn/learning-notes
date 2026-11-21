# Debian

## 系统配置

### 下载源
#### 传统方法
```bash
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo vim /etc/apt/sources.list
```
#### 片段文件 (Debian 6.0+)
```bash
ls -la /etc/apt/sources.list.d/
sudo bash -c 'for f in trixie{,-backports,-security,-updates}; do sed "s|deb\.debian\.org|mirrors.ustc.edu.cn|g" /etc/apt/sources.list.d/50-$f.list > /etc/apt/sources.list.d/10-$f-mirror.list; done'
cat /etc/apt/sources.list.d/10-trixie-*.list # 检查策略
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
