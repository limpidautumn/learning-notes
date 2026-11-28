# SWAP 交换空间 / 虚拟内存

## 检查当前 swap 状态
```bash
free -h
swapon --show
```

## swap 文件
### 创建
```bash
sudo fallocate -l 2G /swapfile # 创建 swap 文件
sudo chmod 600 /swapfile
sudo mkswap /swapfile # 格式化为 swap
```

编辑 `/etc/fstab`，追加一行：
```text
/swapfile none swap sw 0 0
```

重启后生效。

### 扩展
```bash
sudo swapoff /swapfile
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

## swap 分区
```bash
sudo mkswap /dev/sdXn
sudo blkid /dev/sdXn # 查看 UUID
```

编辑 `/etc/fstab`，追加一行：
```text
UUID=<UUID> none swap sw 0 0
```

重启后生效。
