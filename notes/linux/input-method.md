# 输入法

## Fcitx 5 安装流程

### KDE Plasma (Wayland)

以 Debian 13 为例。

**安装 apt 包**

```bash
sudo apt install fcitx5 fcitx5-chinese-addons fcitx5-frontend-all fcitx5-config-qt
```

- `fcitx5-frontend-all`: 包含 GTK3, GTK4, Qt5, Qt6 的 IM 模块;
- `fcitx5-config-qt`: 提供 `fcitx5-configtool`;
- `im-config` 会作为推荐被自动安装.

**配置环境变量**

配置 systemd 用户会话环境变量。

```bash
mkdir -p ~/.config/environment.d
vim ~/.config/environment.d/im.conf
```

写入内容：

```text
XMODIFIERS=@im=fcitx
```

Wayland 原生应用通过 text-input-v3 通信；如果全局设置 GTK/Qt 的 IM module，就会和 fcitx5 的 Wayland 前端相互冲突。

**配置 kWin**

系统设置 System Settings > 键盘 Keyboard > 虚拟键盘 Virtual Keyboard

选 `Fcitx 5` 或 `Fcitx 5 Wayland Launcher (Experimental)`。推荐选 Waylan Launcher，更简单。

**配置 im-config**

`im-config` 是 Debian 的输入法配置框架，需要禁用以避免环境变量注入。

```bash
im-config -n none
```

**应用**

重启计算机，应用更改。
