# Ubuntu

## 系统配置
### 主机名
```bash
hostnamectl # 查看当前主机名
sudo hostnamectl set-hostname my-hostname # 修改主机名
```

### 下载源
#### 传统方法
```bash
lsb_release -a # 查看版本
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup # 备份
sudo vim /etc/apt/sources.list
# deb https://mirrors.ustc.edu.cn/ubuntu/
```
### deb822 (Ubuntu 24.04+)
```bash
sudo cp /etc/apt/sources.list.d/ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources.backup # 备份

sudo sed -i 's|http://archive.ubuntu.com/ubuntu|https://mirrors.ustc.edu.cn/ubuntu|g; s|http://security.ubuntu.com/ubuntu|https://mirrors.ustc.edu.cn/ubuntu|g' /etc/apt/sources.list.d/ubuntu.sources # 自动替换

sudo vim /etc/apt/sources.list.d/ubuntu.sources # 手动修改
# URIs: https://mirrors.ustc.edu.cn/ubuntu/
```
