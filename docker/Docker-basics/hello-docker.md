## 为什么要用Docker

环境隔离性强（应用隔离，互不打扰）

跨平台，内部为Centos或者ubuntn的文件可运行在Mac Linux Windos等多个平台

可快速构建或删除，使用现成的Docker镜像快速构建各种开发环境，切性能远远强于虚拟机

可以轻松迁移和进行扩展

总结下来就是 为了更高效的去搭建各种开发环境，解决各种环境迁移扩展复杂的痛点

## docker基本概念和基本操作
Docker基于Go语言，dotCloud公司开发

Docker镜像（系统盘）：只读的模版，里边包含了一套自定义的开发环境配置，可以理解为装系统的U盘。可自建镜像

常见操作以及一个小demo

列出可用镜像列表 
```
$ docker images 
```


获取一个新的镜像
```
$ docker pull ubuntu:13.10
```


查找镜像
```
$ docker search httpd
```

使用镜像

```
$ docker run httpd
```

删除镜像

```
$ docker rmi hello-world
```

创建镜像
从已经创建的容器中更新镜像，

构建镜像

先创建一个Dockerfile文件
```
$ mkdir Dockerfile
```
Dockerfile内容
```
FROM alpine:latest
Maintainer start
CMD echo "hi MarginGao"
```

创建镜像
```
docker build -t gc .
```
-t 指定要创建的目标镜像名

使用新的镜像创建一个容器 输出 hi MarginGao

```
docker run gc
hi MarginGao
```



Docker容器（集装箱）：容器用来隔离应用，使用镜像创建

创建容器
```
$ docker run -t ubuntu /bin/bash
```
-t 终端
ubuntu  ubuntu 镜像
/bin/bash  命令，我们希望有个交互式的shell
此时我们以及进入docker创建好的ubuntu容器内部
退出终端  exit


后台运行
大部分场景下我们希望docker的服务是运行在后台的，通过-d指定容器的运行模式，加了-d参数默认不会进入容器，想要进入容器需要使用指令
docker exec

```
$ docker run -itd --name ubuntu-tet ubuntu /bin/bash
``` 
进入带-d参数的容器

```
docker exec -it 容器id /bin/bash
```

删除容器

```
$ docker rm -f 1e560fca3906
```