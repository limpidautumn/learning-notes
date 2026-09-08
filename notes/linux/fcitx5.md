# Wayland 环境下的 Fcitx 5

## 安装 Fcitx 5
KDE Plasma 可以从 Discover 中安装 `Fcitx 5 - Chinese Addons`。

## 设置环境变量
```bash
mkdir -p ~/.config/environment.d
vim ~/.config/environment.d/im.conf
```

```ini
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=ibus
```
