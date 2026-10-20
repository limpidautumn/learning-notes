# LLVM

## 安装
### Debian / Ubuntu
[apt.llvm.org](https://apt.llvm.org/)

```bash
sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
```

创建符号链接：

```bash
ls /usr/bin/clang*  # 查看已安装版本，下面以 22 为例。
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-22 220  # clang
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-22 220  # clang++
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-22 220  # clangd
```

## clang

clang++ 与 g++ 的用法基本一致。
