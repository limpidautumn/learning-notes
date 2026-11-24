# hostnamectl

```bash
hostnamectl # 查看当前主机名
sudo hostnamectl set-hostname my-hostname # 修改主机名
```

## 常见问题

### 本机主机名解析失败

**问题现象**

使用 hostnamectl 更改主机名称后，执行 sudo 命令时会卡几秒，且总是报错：

```text
sudo: unable to resolve host <new-hostname>: Name or service not known
```

**解决方法**

这是名称解析问题。

Debian 系的 `/etc/hosts` 中，默认会有映射：

```text
127.0.0.1 localhost
127.0.1.1 <old-hostname>
```

编辑文件，将新主机名写入原位置即可。注意是 `127.0.1.1` 而非 `127.0.0.1`。
