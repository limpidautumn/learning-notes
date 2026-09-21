# 设备

## udev
现在由 systemd 维护。

[udev](https://www.freedesktop.org/software/systemd/man/latest/udev.html)

规则文件目录：
- `/etc/udev/rules.d`
- `/run/udev/rules.d`
- `/usr/lib/udev/rules.d`
- `/usr/local/lib/udev/rules.d`
合并统一字典序排序，重名则顺序覆盖。

## USB
```bash
lsusb
ls -l /dev/bus/usb/xxx/xxx
```

将所有 USB 设备交给 `plugdev` 组。

```bash
sudo groupadd -f plugdev
sudo usermod -aG plugdev "$USER"

sudo vim /etc/udev/rules.d/99-usb-plugdev.rules
```

```udev
# 所有 USB 设备节点
SUBSYSTEM=="usb", GROUP="plugdev", MODE="0660"

# 任何父设备属于 USB 的设备节点
# SUBSYSTEMS=="usb", GROUP="plugdev", MODE="0660"
```

```bash
sudo udevadm control -R # 重新加载规则
sudo udevadm trigger # 重放设备事件
```

## 串口设备
先看用户组。大多数 Linux 发行版使用 `dialout`，Arch/Manjaro 等使用 `uucp`。
```bash
ls -l /dev/ttyXXXn # root dialout
sudo usermod -aG dialout "$USER"
```
