# SWAP 交换空间 / 虚拟内存

## 检查当前 swap 状态
```bash
free -h
swapon --show
```

## 创建 swap 文件

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

### 创建 swap 分区
```bash
sudo mkswap /dev/sdXn
sudo blkid /dev/sdXn # 查看 UUID
```

编辑 `/etc/fstab`，追加一行：
```text
UUID=<UUID> none swap sw 0 0
```

重启后生效。
