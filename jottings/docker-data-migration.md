# 随记：docker 数据迁移

已在版本 29.10.1 (新安装) 验证。

```text
Docker version 29.10.1, build c48360f
```

## data-root 迁移

[Configure the data directory location - Docker](https://docs.docker.com/engine/daemon/#configure-the-data-directory-location)

```bash
# 检查版本及状态
sudo docker --version  # 检查版本, 至少 17.05+, 写这段流程时是 29.10.1
sudo docker info -f '{{.DockerRootDir}}'  # 确认其为 /var/lib/docker

# 迁移文件
TARGET_DOCKER_DATA=/data/docker  # 迁移到的目标路径
sudo systemctl stop docker docker.socket  # 停止进程
sudo mkdir -p "$TARGET_DOCKER_DATA"
sudo rsync -aHAX /var/lib/docker/ "$TARGET_DOCKER_DATA"/  # 拷贝文件

# 改 daemon.json
sudo cat /etc/docker/daemon.json  # 检查是否存在, 以及内容是否为空
# 根据情况, 选择下面两操作之一:
# 1. 若不存在或为空, 写内容;
sudo mkdir -p /etc/docker
echo "{\"data-root\":\"$TARGET_DOCKER_DATA\"}" | sudo tee /etc/docker/daemon.json
# 2. 若已有内容, 备份并扩充.
sudo cp -a /etc/docker/daemon.json{,.bak}
sudo python3 -c "import json,sys;p='/etc/docker/daemon.json';d=json.load(open(p));d['data-root']=sys.argv[1];json.dump(d,open(p,'w'),indent=2)" "$TARGET_DOCKER_DATA"

# 启动并验证
sudo systemctl start docker
sudo docker info -f '{{.DockerRootDir}}'  # 检查当前 data-root
sudo docker images
sudo docker ps -a
sudo docker run --rm hello-world

# 旧数据
sudo mv /var/lib/docker{,.old}  # 先改名保留 
sudo rm -rf /var/lib/docker.old  # 稳定后, 清理
```

> **挂载数据盘**
> 
> 对 fsatb 的建议：
> ```text
> UUID=1234abcd-5678-90ef-1234-567890abcdef /data ext4 defaults,noatime,nofail,errors=remount-ro,x-systemd.device-timeout=10s 0 0
> ```
> 盘不在时，不阻塞开机，以进系统救援。
> 
> 写 `/etc/systemd/system/docker.service.d/require-mount.conf`：
> 
> ```ini
> [Unit]
> RequiresMountsFor=/data
> ```
> 
> ```bash
> sudo systemctl daemon-reload
> ```
> 
> docker 宁可不启动，也不要写到根分区，以避免挂载时覆盖。

## containerd 迁移

[Docker daemon configuration - Docker](https://docs.docker.com/engine/daemon/)

在 docker 版本 29.0 全新安装的机器上，需要同步迁移 containerd。

```bash
# 检查版本及状态
sudo docker info -f '{{.Driver}}' && sudo docker info -f '{{.DriverStatus}}'  # 确认出现 overlayfs (containerd image store), 或出现 io.containerd.snapshotter.v1
sudo docker --version  # 检查版本, 写这段流程时是 29.10.1
sudo cat /etc/containerd/config.toml  # 查看当前 root 值, 下面的流程假设其为默认值 /var/lib/containerd

# 迁移文件
TARGET_CONTAINERD_DATA=/data/containerd  # 迁移到的目标路径
sudo systemctl stop docker docker.socket containerd  # 停止进程
sudo mkdir -p "$TARGET_CONTAINERD_DATA"
sudo rsync -aHAX /var/lib/containerd/ "$TARGET_CONTAINERD_DATA"/  # 拷贝文件

# 修改配置文件
sudo cp -a /etc/containerd/config.toml{,.bak}  # 备份配置文件
# 两种方法选其一
# 1. 手动修改 (推荐)
sudo vim /etc/containerd/config.toml  # 修改或添加 root = "<迁移到的目标路径>"
# 2. 自动重新生成 + 修改 (不推荐)
sudo containerd config default | sudo tee /etc/containerd/config.toml >/dev/null  # 重新生成完整配置
sudo sed -i "s|^root = .*|root = \"$TARGET_CONTAINERD_DATA\"|" /etc/containerd/config.toml  # 修改配置文件
grep -n '^root' /etc/containerd/config.toml  # 必须只有一行，且是新路径

# 启动并验证
sudo systemctl start containerd && sudo systemctl start docker
sudo docker images
sudo docker ps -a
sudo docker run --rm hello-world

# 旧数据
sudo mv /var/lib/containerd{,.old}  # 先改名保留 
sudo rm -rf /var/lib/containerd.old  # 稳定后, 清理
```

> **挂载数据盘**
> 
> 同上，写 `/etc/systemd/system/containerd.service.d/require-mount.conf`：
> 
> ```ini
> [Unit]
> RequiresMountsFor=/data
> ```
> 
> ```bash
> sudo systemctl daemon-reload
> ```
> 
> containerd 宁可不启动，也不要写到根分区，以避免挂载时覆盖。
