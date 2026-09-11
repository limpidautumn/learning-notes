# Vitural Machine Manager (virt-manager)

## 共享文件系统
### 设备
```bash
sudo apt update && sudo apt install virtiofsd
```

在 virt-manager 中，打开对应 VM。

Vitural Hardware Details > Add Hardware > Filesystem

Driver: virtiofs

### 挂载
进入 Guest。

```bash
mkdir -p /path/in/guest
sudo mount -t virtiofs "/path/in/guest" /path/in/guest
```

### 权限
好像没有权限问题？
