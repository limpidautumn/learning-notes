# 网络

## 静态 IP 地址
切到 DHCP，看当前配置：
- 查看连接状态：`ip addr show`，记下网卡名。
- 查看网关：`ip route`，记下网关。它是紧跟在 `via` 后面的那个地址。

假设：
- 目标网卡是 `eth0`
- 所在网段是 `192.168.1.0/24`
- 网关是 `192.168.1.1`

需要先确认是谁在管理网络。

### ifupdown
1. 条件
```bash
systemctl status networking # Active
```

2. 配置
```bash
sudo cp /etc/network/interfaces{,.bak}
sudo vim /etc/network/interfaces
```

```
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.168.1.100/24
    gateway 192.168.1.1
    dns-nameservers 192.168.1.1
```

3. 应用
```bash
sudo ifdown eth0
sudo ifup eth0
ip a # 检查
```

### Netplan (Ubuntu 18.04+)
1. 条件
```bash
sudo netplan status --all # 查看 Netplan 状态
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
### 其它方法
- systemd-networkd
- nmcli

## 网桥
### 终端命令（未验证）
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

### 图形化界面 (KDE Plasma)
TODO.
