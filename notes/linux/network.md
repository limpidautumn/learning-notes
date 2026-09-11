# 网络

## 应用层

## 传输层

## 网络层

### 静态 IP 地址

#### Netplan (Ubuntu 18.04+)
1. 查看网卡名称
```bash
ip a
# 或 ifconfig
```

2. 配置 Netplan
```bash
ls /etc/netplan/ # 查看已有配置
sudo vim /etc/netplan/01-netcfg.yaml
```

```yaml
network:
  version: 2
  ethernets:
    eth0: # Network adapter
      dhcp4: no
      addresses:
        - 192.168.1.100/24 # IP address / prefix length
      routes:
        - to: default
          via: 192.168.1.1 # Gateway
      nameservers:
        addresses:
          - 1.1.1.1 # DNS server
          - 1.0.0.1

```

```bash
sudo chmod 600 /etc/netplan/01-netcfg.yaml # 修改权限
```

3. 应用配置
```bash
sudo netplan apply
```

## 链路层

### 网桥
#### 终端命令（未验证）
假设 `eno1` 为原网卡，DHCP。将其作为桥端口，使用 `nmcli` 创建网桥 `br0`。

```bash
# 查看当前连接
nmcli con show
nmcli dev status

# 创建网桥
sudo nmcli con add type bridge con-name br0 ifname br0 \
  ipv4.method auto bridge.stp no

# 把 eno1 作为 br0 的从属
sudo nmcli con add type bridge-slave con-name eno1-br ifname eno1 master br0

# 禁止旧连接自动连接并断开
sudo nmcli con mod "Wired connection 1" connection.autoconnect no
sudo nmcli con down "Wired connection 1"

# 启用网桥
sudo nmcli con up br0

# 验证成功后再删除旧连接
sudo nmcli con delete "Wired connection 1"
```

#### 图形化界面 (KDE Plasma)
TODO.
