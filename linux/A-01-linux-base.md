# linux 基础篇

## 目录

- 为什么要学习 Linux
- Linux的历史
- Linux系统认知
- Linux 系统目录结构

## 为什么要学习 Linux

相信大部人步入社会后，在学习新的知识内心想法总有目的性，或许是因为工作硬性需求，或许自己的兴趣爱好，也或许因为真香定律的诱惑。

那么我们学习Linux基础后有什么好处呢？

学好入门的Linux基础知识，例如：在部署前端项目中碰到问题，也有能力适当的解决排查问题能力或思维！不至于在碰到问题发版不了只能找运维解决。

以及在后面学习docker无压力，docker也是需要必备linux一些基础知识。

``` BASH
cd /home
ls
clear
rm -r node_moduels
```

## Linux的历史

Linux 内核最初是由李纳斯•托瓦兹（Linus Torvalds）在赫尔辛基大学读书时出于个人爱好而编写的，当时他觉得教学用的迷你版 Unix 操作系统 Minix 太难用了，于是决定自己开发一个操作系统。Linux第 1 版本于 1991 年 9 月发布开源。

Mac系统其实是基于Unix内核开发的，但Unix和Linux上使用很多指令基本都通用的！

## Linux系统认知

Linux系统有很多个不同发行版本，Linux的发行版说简单点，就是将Linux内核与应用软件做一个打包。

Linux可安装在各种计算机硬件设备中，比如手机、平板电脑、路由器、嵌入式硬件、台式计算机、游戏机和超级计算机等等。

较知名的发行版有：Ubuntu、CentOS、RedHat、Debain、Kali、Fedora、Bodhi、OpenSUSE、Turbolinux、Neptune、Solus、Zorin、SlackWare等

## 搭建基础的Linux环境

1. 下载docker软件安装，docker顶部图标右侧 > Preferences选项 > Docker Engine 配置参数（镜像加速）

``` json
{
  "experimental": false,
  "debug": true,
  "registry-mirrors": [
    "https://gd77gs75.mirror.aliyuncs.com"
  ],
  "builder": {
    "gc": {
      "enabled": true,
      "defaultKeepStorage": "20GB"
    }
  }
}
```

<div><img src="https://img.kaikeba.com/a/14815152501202aeci.png" /></div>

2. 下载Linux环境(ubuntu系统)，并进入ubuntu系统环境。

终端输入：

``` BASH
docker pull ubuntu
docker run -d -it --name ubuntu -p 6000:6000 ubuntu
docker attach ubuntu # 进入ubuntu系统
apt update # 更新apt资源
apt install sudo wget vim xz-utils -y # 安装需要的软件包
```

PS: 输入exit退出系统！

在次进入ubuntu系统环境，终端输入：

``` BASH
docker start ubuntu
docker attach ubuntu
```

## Linux 系统目录结构

<img src="https://segmentfault.com/img/remote/1460000038497713/view" />

### 常用目录

- /bin 存放常用的终端命令的目录(可执行文件或可执行文件的链接)，例如：ls、cd、pwd 等等
- /sbin 存放系统二进制文件（超级用户）
- /usr 存放的是一些非系统必须的资源，比如用户安装的应用程序。
  - /usr/bin 是你在后期安装的一些软件的运行脚本
  - /usr/sbin 放置一些用户安装的系统管理的必备程式
- /home 用户的主目录，在Linux中每个用户都有一个自己的目录
- /tmp 目录是用来存放一些临时文件的。
- /etc 目录用来存放系统中的配置文件，基本上所有的配置文件都可以在这里找到。例如：配置系统环境变量
  - /etc/profile 用来设置系统环境参数，对系统内所有用户生效
- /root 该目录为系统管理员，也称作超级权限者的用户主目录。

### 其它目录介绍

- /dev 该目录下存放的是Linux的外部设备，在Linux中访问设备的方式和访问文件的方式是相同的
- /lib 这个目录里存放着系统最基本的动态连接共享库，其作用类似于Windows里的DLL文件。几乎所有的应用程序都需要用到这些共享库。
- /opt 这是给主机额外安装软件所摆放的目录。比如你安装一个ORACLE数据库则就可以放到这个目录下。默认是空的。
- /media linux系统会自动识别一些设备，例如U盘、光驱等等，当识别后，linux会把识别的设备挂载到这个目录下。
- /mnt 系统提供该目录是为了让用户临时挂载别的文件系统的，我们可以将光驱挂载在/mnt/上，然后进入该目录就可以查看光驱里的内容了。
- /proc 这个目录是一个虚拟的目录，它是系统内存的映射，我们可以通过直接访问这个目录来获取系统信息。
- /srv 该目录存放一些服务启动之后需要提取的数据。
- /run 和 /sys 用来存储某些程序的运行时信息和系统需要的一些信息
- /var 这个名字是历史遗留的，现在该目录最主要的作用是存储日志（log）信息，比如说程序崩溃，防火墙检测到异常等等信息都会记录在这里。

## Linux常用基础命令

ls命令 – 显示指定工作目录下的内容及属性信息

cd命令 – 进入指定路径目录内

``` BASH
# 语法格式：cd [目录]
cd /home # 进入home目录
cd .. # 返回上一级目录
cd / # 进入系统根目录
```

pwd命令 – 显示当前路径
mkdir命令 – 创建目录

``` BASH
# 语法格式：mkdir [参数] [目录]
# 常用参数
-p 递归创建多级目录
-m 建立目录的同时设置目录的权限
-v 显示目录的创建过程

mkdir zbook # 创建一个 zbook 的目录
mkdir zbook1 zbook2 zbook3 # 同时创建多个子目录
mkdir -p /my/zbook # 递归创建目录
mkdir -m 700 /usr/zbook # 在usr目录下建立子目录zbook，并且设置文件属主有读、写和执行权限，其他人无权访问
```

touch命令 – 创建文件

``` BASH
# 语法格式：touch <文件名>
touch file.md
touch zbook/file.md
```

vim命令 - 文本编辑器

``` BASH
# 语法格式：vim <文件名>
vim /file.md

1、按键【I】进入编辑模式
2、按【esc】键，取消编辑状态
输入:wq 退出并保存
输入:q 退出
输入:q! 强制退出，并且不保存编辑内容
```

cat命令 – 在终端设备上显示文件内容

``` BASH
# 语法格式：cat [参数] [文件]
# 常用参数：
-n 显示行数（空行也编号）
-s 显示行数（多个空行算一个编号）
-b 显示行数（空行不编号）

cat file.md
cat -n file.md # 查看文件，并显示行数
```

rm命令 – 移除文件或目录

``` BASH
# 语法格式：rm [参数] [文件]
# 常用参数
-f 忽略不存在的文件，不会出现警告信息
-i 删除前会询问用户是否操作
-r/R 递归删除

rm -i file.md # 删除前逐一询问确认，按y确认

rm -f file.md # 直接删除文件，不会有任何提示

rm -rf my # 递归删除文件及目录
rm -rf zbook1 zbook2 zbook3 # 同时删除多个目录

rm -rf * # 删除当前目录下所有文件（谨慎）
```

mv命令 – 移动或改名文件

``` BASH
# 语法格式：mv [待移动文件] [移动到指定路径]
mv file_1 file_2

mv file.md zbook/ # 移动文件到指定目录内
mv /zbook/ /usr/newbook # 把zbook目录移动到 usr目录内，并且把zbook改名成newbook
```

cp命令 – 复制文件或目录

``` BASH
# 语法格式：cp [参数] [复制文件] [复制到指定路径]
# 常用参数
-r 递归复制文件和目录
-f 若目标文件已存在，则会直接覆盖原文件
-i 若目标文件已存在，则会询问是否覆盖

cp -r zbook /home/ # 复制zbook目录 到 home目录内
cp -rf zbook /home/hello # 复制zbook目录 到 home目录内，并且把zbook目录名更改成 hello

cp -f /zbook/file.md /home/yyds.md # 复制file.md文件到home目录内，并将文件名更改成 yyds.md
```

## 在Linux系统安装node

tar命令 – 解压缩文件

``` BASH
# 语法格式：tar [参数] [文件]
# 常用参数：
x - 提取文件
v -详细列出已处理的文件
f -使用指定的存档文件

tar xf mydata.tar.gz # 解压mydata.tar.gz文件到当前目录内
```

实战安装流程：

``` BASH
cd /tmp

# 下载node包 http://nodejs.cn/
wget https://npm.taobao.org/mirrors/node/v14.16.1/node-v14.16.1-linux-x64.tar.xz

# 解压node**.xz后缀文件
tar xf node-v14.16.1-linux-x64.tar.xz

# 移动目录到usr内，并且改名成node目录
mv node-v14.16.1-linux-x64 /usr/node

# 编辑环境变量文件
vim /etc/profile

# 在编辑文件时，加入以下参数
export NODE_HOME=/你解压完的node文件路径
export PATH=$NODE_HOME/bin:$PATH

# 更新环境变量
source /etc/profile

# 验证node是否安装成功
node -v
```
