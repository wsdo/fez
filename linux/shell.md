# shell

## linux 架构

### linux历史回顾
Linux开始于GNU，当年的GNU已经完成了大部分系统相关的工作，但是就是没有内核。
后来，一个叫linus的人完成了一个可以被GNU对接的内核，取名叫做Linux。
所以说，严格来讲Linux只是一个操作系统内核，而不是一个真正的操作系统。
### Linux操作系统的架构：
![img.png](https://n.devland.cn/images/shell/1622006950688.png)
### shell
通过架构图片我们可以看出，shell顾名思义,是用户可以与系统进行交互的一个界面。
  
### shell脚本
我们通过shell这个操作系统的组成之一的应用程序实现了对操作系统内核的访问和控制。
但我们的访问需求往往是带有复杂逻辑的需求，简单的命令语句无法满足我们的需求，于是计算机先驱们又开发出了能够兼容shell命令的脚本编程语言。
这个语言就叫做shell（没错，和shell程序同名）。
因为二者基本上已经互为互补的关系，所以现在打开shell客户端基本上就默认运行在某一种shell语言环境下了。

为什么是"某一种shell语言"？

### 不同的shell环境
时代在发展，人们对shell的需求也在不断发展，所以就出现了各种不同的shell语言，这些语言都是在基础的shell语言上面发展起来的。
shell的分类主要有：zsh,bash,csh,tsh等等。sh（Bourne shell）是第一个shell,也是unix上标准的shell。
linux默认使用bash，zsh是很多人喜欢用的shell版本。
各种shell之间基本一致。

### 切换shell
查看当前shell环境
```shell
echo $SHELL
```

切换shell环境
```shell
chsh -s /bin/zsh
```

如果没有zsh在系统里面，我们需要提前安装zsh才能成功切换
```shell
apt-get install zsh
```

安装之后可以再为zsh搭配一个好看的主题
```shell
apt install git
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh
sh install.sh
```

### 总结
shell是什么
shell的分类
切换shell

### 作业
安装一个不同版本的shell，切换过去；
