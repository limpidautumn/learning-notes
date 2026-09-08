# Linux 桌面环境
[freedesktop.org](https://www.freedesktop.org/)

## Desktop Entry
[文档](https://specifications.freedesktop.org/desktop-entry/latest-single/)
为单个可执行文件在开始菜单中创建图标，需要创建一个 `.desktop` 文件。

桌面环境会扫描以下目录中的 .desktop 文件：
- 用户级：`~/.local/share/applications/`
- 系统级：`/usr/share/applications/`

在这些目录中创建 `myapp.desktop`。

```ini
[Desktop Entry]
Type=Application
Name=My App
Exec=/path/to/myapp
Icon=/path/to/myapp.png
Terminal=false
Categories=Development;
```
