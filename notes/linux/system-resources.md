# 系统资源监控

```bash
sudo apt install sysstat # mpstat, iostat, pidstat
```

## CPU
```bash
mpstat -P ALL # CPU 各核心使用情况
htop # 各进程的 CPU 使用率
```

## 内存
```bash
free -h # RAM 及 Swap 使用情况
```

## 磁盘
```bash
iostat # 磁盘 I/O
```
