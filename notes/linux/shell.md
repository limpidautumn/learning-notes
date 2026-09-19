# Linux Shell

## 特性
### 单引号 / 双引号
```bash
sudo bash -c "echo '$HOME'" # 输出：/home/ubuntu
sudo bash -c 'echo "$HOME"' # 输出：/root
```

| 特性 | 单引号 `''` | 双引号 `""` |
| :--: | :--: | :--: |
| 变量展开 `$var` | 不展开，保持原样 | 展开为变量值 |
| 命令替换 `$(cmd)` | 不执行，保持原样 | 执行并替换为输出 |
| 转义字符 `\` | 失去特殊意义 | 保留特殊性 |
| 包含引号本身 (二级性质) | 不能通过 `\'` 包含 | 可以用 `\"` 包含 |

### 命令前缀赋值
```bash
VAR="abc" echo $VAR # 输出：(空)
VAR="abc"; echo $VAR # 输出：abc
```

## 用法
### 后台进程

```bash
# nohup: 忽略 SIGNUP 信号，让命令在退出终端后仍然继续运行
nohup COMMAND &
nohup COMMAND > LOGFILE 2>&1 &
```
