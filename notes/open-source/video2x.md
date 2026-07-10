# Video2X 部署记录
[GitHub](https://github.com/k4yt3x/video2x) | [Documentation](https://docs.video2x.org/)

```bash
cd ~
sudo apt update -y
sudo apt install curl -y

# 安装 Video2X
curl -L -o video2x.AppImage https://github.com/k4yt3x/video2x/releases/download/6.4.0/Video2X-x86_64.AppImage
chmod +x video2x.AppImage
./video2x.AppImage --appimage-extract
sudo mv squashfs-root /opt/video2x
rm video2x.AppImage
sudo ln -s /opt/video2x/usr/bin/video2x /usr/local/bin/video2x
ln -s /opt/video2x/usr/share/video2x/models ~/models

# 安装依赖
video2x # 缺什么补什么
sudo apt install libvulkan1 -y # libvulkan.so.1
sudo apt install libharfbuzz0b -y # libharfbuzz.so.0
sudo apt install libfribidi0 -y # libfribidi.so.0
sudo apt install libfontconfig1 -y # libfontconfig.so.1
sudo apt install libasound2 -y # libasound.so.2
sudo apt install libgpg-error0 -y # libgpg-error.so.0

# 安装对应显卡的 vulkan 驱动
sudo apt install vulkan-tools
vulkaninfo --summary # 检查 GPU 加速生效情况

# 使用
video2x -i input.mp4 -o output.mp4 -p realesrgan -s 4 --realesrgan-model realesr-animevideov3
```
