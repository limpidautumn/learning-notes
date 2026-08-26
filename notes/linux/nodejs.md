# NodeJS

[Download](https://nodejs.org/en/download)

选择 `LTS` for `Linux` using `nvm`。

## 常见问题

### JavaScript heap out of memory

Node.js 默认堆上限较低，增加堆内存上限。

```bash
vim ~/.bashrc
```

```bash
export NODE_OPTIONS="--max-old-space-size=1024"
```
