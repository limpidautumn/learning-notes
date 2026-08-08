# 文件系统

## 查看目录
```bash
ls -la [FILE] # 长格式列出目录内所有文件
```

## 目录总大小
```bash
du -sh [FILE] # 估算并显示文件或目录所占用的磁盘空间
```

## 磁盘操作
### 磁盘空间
```bash
df -h # 查看磁盘空间使用情况
df -i # 查看 inode 使用情况
```

### 块设备
```bash
lsblk -f # 查看所有块设备及文件系统信息
sudo fdisk -l /dev/sdX # 查看磁盘信息
```

### 格式化
会清空磁盘所有数据。
```bash
sudo fdisk -l /dev/sdX # 检查
sudo parted /dev/sdX mklabel gpt # 创建分区表
sudo parted /dev/sdX mkpart primary ext4 0% 100% # 分区
sudo fdisk -l /dev/sdX # 检查
sudo mkfs.ext4 /dev/sdX1 # 格式化为 ext4
```

### 挂载
```bash
sudo mkdir -p /mnt/xxx # 创建挂载点

# 挂载 ext4
sudo mount /dev/sdX1 /mnt/xxx
sudo chown -R $USER:$USER /mnt/xxx

# 挂载 NTFS
sudo mount -t ntfs-3g /dev/sdX2 /mnt/xxx

# 挂载 FAT32
sudo mount -t vfat /dev/sdX3 /mnt/xxx

# 取消挂载
lsof /mnt/xxx # 查看进程占用
sudo umount /mnt/xxx # 指定挂载点
sudo umount /dev/sdX1 # 指定设备名

```

### TRIM
触发存储设备执行空间回收，有助于提升 SSD 性能或减少宿主机的磁盘占用。
```bash
sudo fstrim -av # 手动触发 discard
```
