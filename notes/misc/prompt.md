# 提示词

记录一些自己写的、未来可能重复使用的 LLM / AI Agent 提示词。

## git workflow

## 其它

### svg 嵌入文字 & 压缩

- Model: DeepSeek-V4.1-Flash-1017, fingerprint: bc19ba97cbe016479903222bb1578db6
- Agent: @deepseek-ai/dsh@0.2.1-rc.3
- Environmental Requirements: 工作区写权限, 干净目录, svg 图片文件, uv, fonttools.

```txt
You are currently in a temporary working directory, which contains an SVG image file.

Your tasks:
1. Embed the necessary fonts into the file.
2. Reduce the file size as much as possible, while ensuring the visual appearance remains absolutely identical.
3. Report to me your process.

Notes:
1. `fonttools` is installed via `uv` in this environment; you can invoke `pyftsubset`.
2. You are in a temporary working directory. This directory is writable, while all other locations (including the directory itself) are read-only. All files in `/tmp` will be cleared once the bash tool execution concludes.
3. `uv` is installed and available for running temporary scripts. Please ensure the cache is redirected before using `uv`. When creating a virtual environment, you need to use the system python, not the specified version.
4. There are no limits on time, tokens, or CPU resources for this task. You are free to think and debug as you see fit.
5. Your image recognition capability is limited; avoid reading images directly whenever possible. For this task, you may examine the SVG source file to analyze its structure, but do not convert it to PNG format for visual inspection.
```
