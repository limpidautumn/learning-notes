# Docker

## 配置

### 安装

[安装](https://get.docker.com/) | [Get started](https://docs.docker.com/get-started/)

```bash
curl -fsSL https://get.docker.com | sudo sh
```

> 如需代理，配置环境变量：
> 
> ```bash
> curl -fsSL https://get.docker.com -o install-docker.sh
> sudo https_proxy=http://127.0.0.1:40000 \
>   http_proxy=http://127.0.0.1:40000 \
>   no_proxy=localhost,127.0.0.1 \
>   sh install-docker.sh
> ```

检查：

```bash
docker version
```

> 若报错：`permission denied while ...`，可选择启用 rootless 模式 (不推荐, 会导致配置文件混乱)。
> 
> 运行：
> ```bash
> # 将当前用户添加到 docker 组，以获得 Docker 守护进程的访问权限
> sudo usermod -aG docker $USER
> # 需要重新登录
> docker version
> ```
> 
> 或接受每次 `sudo` (推荐)。

### 代理

#### Docker Daemon 代理

影响 docker pull / push 及 docker build 的 FROM 基础镜像拉取过程。不影响 docker build 的 apt 等工具。

写 `/etc/systemd/system/docker.service.d/http-proxy.conf`：

```ini
[Service]
Environment="HTTP_PROXY=http://127.0.0.1:7890"
Environment="HTTPS_PROXY=http://127.0.0.1:7890"
Environment="NO_PROXY=localhost,127.0.0.1,::1"
```

重载并重启：

```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```

验证：

```bash
docker pull hello-world  # 观察能否拉取
```

## 镜像

### 拉取

```bash
docker pull debian:latest
```

镜像源:
- m.daocloud.io/docker.io by [上海道客网络科技有限公司](https://www.daocloud.io/) [docs](https://docs.daocloud.io/community/mirror/)

Usage:

```bash
docker pull m.daocloud.io/docker.io/library/hello-world
```

### 构建

```bash
# 在当前目录构建镜像
docker build -t [registry/]repository[:tag] .

# 使用代理
docker build --build-arg HTTP_PROXY=http://proxy.example.com:7890 --build-arg HTTPS_PROXY=... --build-arg ALL_PROXY=... --build-arg NO_PROXY=localhost,127.0.0.1,::1 .
```

### 操作

```bash
docker image ls # 查看本地已有的镜像
docker image rm IMAGE # 删除镜像
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

## 数据卷
```bash
docker volume ls
docker inspect VOLUME
docker volume create VOLUME
docker volume rm VOLUME
```

## 清理
```bash
docker system df # 查看 Docker 磁盘空间占用情况
docker image prune -a # 清理未被容器使用的镜像
docker container prune # 清理已停止的容器
docker volume prune # 清理未使用的卷
docker builder prune -a # 清理构建缓存
```

## 数据迁移

见 [docker-data-migration](../../jottings/docker-data-migration.md)。

## 图形化界面

**Portainer**

[portainer/portainer - GitHub](https://github.com/portainer/portainer) | [portainer.io/](https://www.portainer.io/)

**Arcane**

更现代的 Docker 管理 GUI。

[getarcaneapp/arcane](https://github.com/getarcaneapp/arcane) | [Arcane](https://getarcane.app/)

## 示例
### node 应用沙盒
```bash
docker pull node:latest
docker create --name my-node -v /path/to/volume:/data -w /data node:latest sleep infinity
docker start my-node
docker exec -it my-node /bin/bash
docker stop my-node
```
