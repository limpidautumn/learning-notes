# Docker

## 配置

[安装](https://get.docker.com/) | [Get started](https://docs.docker.com/get-started/)

```bash
curl -fsSL https://get.docker.com | sudo sh
```

检查：
```bash
docker version
```

若报错：`permission denied while ...`，运行：
```bash
# 将当前用户添加到 docker 组，以获得 Docker 守护进程的访问权限
sudo usermod -aG docker $USER
# 需要重新登录
docker version
```

## 镜像
```bash
docker pull debian:latest # 拉取镜像
docker images # 查看本地已有的镜像
```

## 容器
### 创建
```bash
docker run IMAGE [COMMAND] # 创建并启动容器
docker create IMAGE [COMMAND]; docker start CONTAINER # 创建容器，稍后启动
```

选项：
- `-d` 后台运行容器，仅 run 有效；start 默认后台
- `-it` 交互式运行，并分配一个伪终端
- `--name 容器名` 为容器指定一个名称
- `-p 宿主机端口:容器端口` 端口映射
- `-v 宿主机路径:容器路径` 挂载数据卷
- `-w 工作目录` 设置进程启动时的当前目录
- `-e 变量=值` 设置环境变量
- `--rm` 容器退出后自动删除
- `--network` 指定容器使用的网络

常用 COMMAND：
- `/bin/bash` 打开终端交互，配合 -it 使用
- `tail -f /dev/null` 指定一个不会自动退出的前台命令作为主进程，使容器保持后台运行
- `sleep infinity` 保持运行

### 操作
```bash
docker ps # 查看正在运行的容器
docker ps -a # 查看所有容器

docker inspect CONTAINER # 查看容器详细信息
docker logs CONTAINER # 查看日志
docker logs -f CONTAINER # 持续跟踪日志输出

docker exec CONTAINER COMMAND # 启动新进程
docker exec -it CONTAINER /bin/bash # 打开终端
docker attach CONTAINER # 将本地输入、输出和错误流附加到正在运行的容器

docker start/stop/restart CONTAINER # 启动/停止/重启
docker rename CONTAINER NEW_NAME # 重命名
docker rm CONTAINER # 删除已停止的容器
docker rm -f CONTAINER # 强制删除正在运行的容器

docker cp CONTAINER:SRC_PATH DEST_PATH
docker cp SRC_PATH CONTAINER:DEST_PATH
```

## 示例
### node 应用沙盒
```bash
docker pull node:latest
docker create --name my-node -v /path/to/volume:/data -w /data node:latest sleep infinity
docker start my-node
docker exec -it my-node /bin/bash
docker stop my-node
```
