# 系统资源监控

```bash
sudo apt install sysstat # mpstat, iostat, pidstat
```

## CPU
```bash
mpstat -P ALL 1  # 报告最近 1 秒内 CPU 各核心平均占用
mpstat -P ALL  # 报告自系统启动以来 CPU 各核心平均占用
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
