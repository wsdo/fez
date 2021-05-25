# linux 基础篇

## 目录

- 为什么要学习 Linux
- Linux的历史
- Linux系统认知
- Linux 系统目录结构


## 为什么要学习 Linux

相信大部人PC端都是用的 window/mac 图形化界面操作系统，日常基本使用也够用，学习成本几乎为零。而Linux不一样，基本都是和字符界面打交道，不直观，麻烦不好玩！

程序员开发日常，无时无刻都在与linux打交道，像我们大部份开发程序软件、app、服务器等等都是放在Linux内核下运行！

``` BASH
cd /home
ls
clear
rm -r node_moduels
```

## Linux的历史

### Linux前身之事

Unix 系统是 Linux 系统的前身。在目前主流的服务器端操作系统中，Unix诞生于 20 世纪 60 年代末，Windows 诞生于 20 世纪 80 年代中期，Linux 诞生于 20 世纪 90 年代初，可以说 Unix是操作系统中的"老大哥"，后来的 Windows 和 Linux 都参考了 Unix。

Unix 操作系统由肯•汤普森（Ken Thompson）和丹尼斯•里奇（Dennis Ritchie）发明。

<div>
<img src="http://p0.itc.cn/images01/20201128/18c4dfa8f97144eeaf0210151caba562.jpeg" />
<p>肯•汤普森（左）和丹尼斯•里奇（右）</p>
</div>

有意思的是，肯•汤普森当年开发 Unix 的初衷是运行他编写的一款计算机游戏 Space Travel，这款游戏模拟太阳系天体运动，由玩家驾驶飞船，观赏景色并尝试在各种行星和月亮上登陆。他先后在多个系统上试验，但运行效果不甚理想，于是决定自己开发操作系统，就这样Unix 诞生了。

### Linux的来由

Linux 内核最初是由李纳斯•托瓦兹（Linus Torvalds）在赫尔辛基大学读书时出于个人爱好而编写的，当时他觉得教学用的迷你版 Unix 操作系统 Minix 太难用了，于是决定自己开发一个操作系统。第 1 版本于 1991 年 9 月发布，当时仅有 10 000 行代码。

Linux存在着许多不同的Linux版本，但它们都使用了Linux内核。Linux可安装在各种计算机硬件设备中，比如手机、平板电脑、路由器、嵌入式硬件、台式计算机、游戏机和超级计算机等等。

## Linux系统认知

Linux系统会有很多个不同版本的系统，由不同的发行商发布。
Linux的发行版说简单点，就是将Linux内核与应用软件做一个打包。

较知名的发行版有：Ubuntu、CentOS、RedHat、Debain、Fedora、Bodhi、OpenSUSE、Turbolinux、Neptune、Kali、Solus、Zorin、SlackWare等

Linux发行版下载列表（清华镜像）https://mirrors.tuna.tsinghua.edu.cn/

## Linux 系统目录结构

<img src="https://segmentfault.com/img/remote/1460000038497713/view" />

常用目录

- /bin 这是存放常用的终端命令的目录(可执行文件或可执行文件的链接)，例如：ls、mount、rm 等等
- /sbin 这里存放的命令可以对系统配置进行操作，如果想更改配置，就需要 sudo 授权或者切换成超级用户，例如：ifconfig, 普通用户可以使用 ifconfig 查看网卡状态，但是想配置网卡信息，就需要授权了
- /etc 这目录用来存放所有的系统管理所需要的配置文件和子目录，例如：包管理工具 apt，就在 /etc/apt 中就存放着对应的配置
ps: 如果你要修改一些系统程序的配置，十有八九要到 etc 目录下寻找
- /home 用户的主目录，在Linux中，每个用户都有一个自己的目录，一般该目录名是以用户的账号命名的
- /opt 这是给主机额外安装软件所摆放的目录。比如你安装一个ORACLE数据库则就可以放到这个目录下。默认是空的。
- /root 该目录为系统管理员，也称作超级权限者的用户主目录。
- /tmp 这个目录是用来存放一些临时文件的。
- /usr 这里存放的是一些非系统必须的资源，比如用户安装的应用程序。


其它目录介绍

- /dev 该目录下存放的是Linux的外部设备，在Linux中访问设备的方式和访问文件的方式是相同的
- /lib 这个目录里存放着系统最基本的动态连接共享库，其作用类似于Windows里的DLL文件。几乎所有的应用程序都需要用到这些共享库。
- /media linux系统会自动识别一些设备，例如U盘、光驱等等，当识别后，linux会把识别的设备挂载到这个目录下。
- /mnt 系统提供该目录是为了让用户临时挂载别的文件系统的，我们可以将光驱挂载在/mnt/上，然后进入该目录就可以查看光驱里的内容了。
- /proc 这个目录是一个虚拟的目录，它是系统内存的映射，我们可以通过直接访问这个目录来获取系统信息。
- /srv 该目录存放一些服务启动之后需要提取的数据。
- /run 和 /sys 用来存储某些程序的运行时信息和系统需要的一些信息
- /var 这个名字是历史遗留的，现在该目录最主要的作用是存储日志（log）信息，比如说程序崩溃，防火墙检测到异常等等信息都会记录在这里。


## 作业：搭建基础的Linux环境

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

2. 下载Linux环境(centos系统)，并进入centos系统环境。

终端输入：

``` BASH
docker pull centos
docker run -d -it --name centos -p 6000:6000 centos
docker ps # 查看是否启动
docker attach centos # 进入centos系统
```

PS: 输入exit退出系统

判断是否进入Linux系统，如图：

<div><img src="https://img.kaikeba.com/a/60325152501202kkon.png" /></div>

3. 在次进入centos系统环境，终端输入：

``` BASH
docker start centos
docker attach centos
```
