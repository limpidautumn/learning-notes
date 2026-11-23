# NodeJS

## 安装

### nvm

**安装脚本**

[Download](https://nodejs.org/en/download)

选择 `LTS` for `Linux` using `nvm`。

**版本管理**

```bash
nvm install-latest-npm # 更新 npm
```

### NodeSource

NodeSource 是一家商业公司，维护第三方 Node.js APT / RPM 仓库。

[Node.js Distributions - NodeSource](https://nodesource.com/products/distributions)

## 常见问题

### JavaScript heap out of memory

Node.js 默认堆上限较低，增加堆内存上限。

```bash
vim ~/.bashrc
```

```bash
export NODE_OPTIONS="--max-old-space-size=1024"
```
