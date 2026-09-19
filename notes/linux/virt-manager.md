# Vitural Machine Manager (virt-manager)

## 共享文件系统
### 设备
```bash
sudo apt update && sudo apt install virtiofsd
```

在 virt-manager 中，打开对应 VM。

#### 添加
Vitural Hardware Details > Add Hardware > Filesystem

Driver: virtiofs

#### 配置缓存策略
```diff
 <filesystem type="mount" accessmode="passthrough">
   <driver type="virtiofs"/>
+  <binary path="/usr/libexec/virtiofsd" xattr="on">
+    <cache mode="never"/>
+    <!-- or <cache mode="none"/> -->
+  </binary>
   <source dir="/path/to/share"/>
   <target dir="mount_tag"/>
   <address ... />
 </filesystem>
```

### 挂载
进入 Guest。

```bash
mkdir -p /path/in/guest
sudo mount -t virtiofs "/path/in/guest" /path/in/guest
```

### 权限
好像没有权限问题？
