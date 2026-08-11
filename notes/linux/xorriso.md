# xorriso

[GNU xorriso](https://www.gnu.org/software/xorriso/)

使用一次性 CD-R / DVD±R。

## 检查

```bash
xorriso -devices # 列出所有光驱设备
xorriso -outdev /dev/sr0 -list_profiles # 查看支持的光盘类型
xorriso -outdev /dev/sr0 -toc # 查看当前光盘的布局信息
xorriso -dev /dev/sr0 -check_media # 扫描并报告坏块
```

## 数据操作
### 写数据
```bash
sudo xorriso -outdev /dev/sr0 -map /fs/path /disc/path -commit -eject all # 添加到特定目录
sudo xorriso -outdev /dev/sr0 -add ./file -- -commit -eject all # 添加到根目录
```

### 读数据
```bash
xorriso -indev /dev/sr0 -ls /disc/path # 列出目录内容
xorriso -indev /dev/sr0 -outdev /path/to/output.iso -commit -eject all # 输出为 iso 镜像
xorriso -indev /dev/sr0 -check_media data_to=/path/to/output.iso -- -eject # 扫描坏块并输出位 iso 镜像
xorriso -dev /path/to/input.iso -osirrox on -extract / /path/to/output/dir -end # 将 ISO 文件中的全部内容提取到本地目录
xorriso -indev /dev/sr0 -osirrox on -extract /path/to/input.txt /path/to/output.txt -eject # 将特定文件提取到本地目录
```

## 杂项

### 光盘 Optical Disc
#### CD 紧凑型光盘 (Compact Disc)
CD-ROM [ECMA-130](https://ecma-international.org/publications-and-standards/standards/ecma-130/)

#### DVD 数字通用光盘 (Digital Versatile Disc)
DVD-ROM [ECMA-267](https://ecma-international.org/publications-and-standards/standards/ecma-267/)

A. 由一个基板、一个记录层和一个虚拟基板组成。只能从一侧访问该记录层。标称容量为 4.7 GB。
B. 由两个基板和两个记录层组成。从光盘的一侧只能访问其中一个记录层。标称容量为 9.4 GB。
C. 由一个基板、一个虚拟基板以及两个记录层（中间有间隔层）组成。只能从一侧访问这两个记录层。标称容量为 8.5 GB。
D. 由两个基板组成，每个基板包含两个记录层，且这两个记录层之间有间隔层。从光盘的一侧只能访问其中一对记录层。标称容量为 17.0 GB。

4.7 GB = 4.37721610069275 GiB = 4482.26928710938 MiB

由基板、单层记录层和虚拟基板组成。记录层仅能从一侧进行访问。标称容量为 4.7 GB。

##### DVD+R
[ECMA-349](https://ecma-international.org/publications-and-standards/standards/ecma-349/)

120mm 4.7G

#### 存放
DA/T 74—2019

### 相关命令
```bash
echo $(( 0x$(openssl rand -hex 4) ))
sudo dd if=/dev/sr0 of=/path/to/output.iso bs=4M status=progress
```

### 随记
#### 容量
4482.625m
2295104 data blocks

Media checks :        lba ,       size , quality
Media region :          0 ,       8992 , + good
Media region :       8992 ,         32 , + slow
Media region :       9024 ,        832 , + good
Media region :       9856 ,         32 , + slow
Media region :       9888 ,    2284064 , + good

#### 存储成本
```text
DVD+R: 1.2CNY 4.7GB 5y -> 1.2/4.7/5/12 = 0.0043 CNY/month/GB = 0.0006 USD/month/GB
BD: 90CNY 50GB 50y -> 90/50/50/12 = 0.003 CNY/month/GB
WD Red Plus: 3541CNY*2 10TB 10y -> 3541*2/10/1000/10/12 = 0.00590166666667 CNY/month/GB
```
