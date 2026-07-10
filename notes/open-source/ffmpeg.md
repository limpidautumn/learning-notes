# FFmpeg
[GitHub](https://github.com/FFmpeg/FFmpeg)

### 基础指令
```bash
sudo apt install ffmpeg -y # 安装
ffmpeg -i input.mp4 # 检查
```

### 杂项
```bash
# # 合并视频轨和音频轨，以长的为准
# ffmpeg -i video.mp4 -i audio.aac -c:v copy -c

# # 修复 PTS
# ffmpeg -fflags +genpts -i input.mp4 -c copy output.mp4
```

