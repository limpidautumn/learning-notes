# GRUB
GRand Unified Bootloader

[GRUB Documentation](https://www.gnu.org/software/grub/grub-documentation.html)

## 配置
```bash
sudo cp /etc/default/grub{,.bak}  # 备份当前配置
sudo vim /etc/default/grub
```

GRUB Documentation - [6.1 Simple configuration handling](https://www.gnu.org/software/grub/manual/grub/grub.html#Simple-configuration)

```bash
# 'GRUB_DEFAULT'
GRUB_DEFAULT=0  # 默认启动项: <number>, <title>, 'saved'.

# 'GRUB_TIMEOUT'
# Boot the default entry this many seconds after the menu is displayed, unless a key is pressed.
GRUB_TIMEOUT=5  # 等待时间(秒)
# 0 = 不等待, -1 = 一直等待.

# 'GRUB_TIMEOUT_STYLE'
# If this option is unset or set to ‘menu’, then GRUB will display the menu and then wait for the timeout set by ‘GRUB_TIMEOUT’ to expire before booting the default entry. Pressing a key interrupts the timeout.
# If this option is set to ‘countdown’ or ‘hidden’, then, before displaying the menu, GRUB will wait for the timeout set by ‘GRUB_TIMEOUT’ to expire. If ESC or F4 are pressed, or SHIFT is held down during that time, it will display the menu and wait for input... If the timeout expires before either of these happens, it will boot the default entry. In the ‘countdown’ case, it will show a one-line indication of the remaining time. 
GRUB_TIMEOUT_STYLE=menu  # 显示菜单

# 'GRUB_TERMINAL'
GRUB_TERMINAL=console  # 禁用图形界面
```

```bash
sudo update-grub  # 根据当前配置重新生成 GRUB 启动菜单配置文件
```

## 使用

```bash
sudo systemctl reboot --firmware-setup  # 重启并进入 BIOS/UEFI
sudo grub-reboot X  # 重启并进入第 X 菜单项
```
