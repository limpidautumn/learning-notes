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
