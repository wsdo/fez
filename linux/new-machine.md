---
title: 新Linux常用操作
categories: "react"
---


## 新的Linux常用操作

#### 修改主机名字
```
vi /etc/hosts
重启 reboot 生效
```
查看当前发行版可以使用的shell
[jack@localhost ~]$ cat /etc/shells 

#### update apt-get && install git zsh
```
apt-get update && apt-get -y install git zsh && sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```

#### 更换主题

vim ~/.zshrc
改成 ys

下面介绍下好用的主题: ys
##### 应用主题
source ~/.zshrc

#### 添加用户
useradd stark
#### 创建用户家目录
mkdir -p /home/stark
#### 给用户家目录
chown -R stark:stark /home/stark
#### 授权于用户sudo权限
gpasswd -a stark sudo
#### 设置用户密码
passwd stark
usermod -s /bin/bash stark

#设置docker权限
usermod -a -G docker stark
#设置bash
usermod -s /bin/bash stark
#设置密码
passwd stark

## generate ssh-keygen
```
cd ~
ssh-keygen -t rsa -C 'wsd312@163.com'
cat .ssh/id_rsa.pub
```

#### mac set Quick Connect machine
```
vim .ssh/config

Host stark
Hostname 182.92.239.218
User wsd
Port 19422
IdentityFile ~/.ssh/id_rsa
```
#### 连接方式
```
ssh stark
```

#在服务器上配置
mkdir /home/stark/.ssh && vim /home/stark/.ssh/authorized_keys

\\\
content
\\\


在新用户下面执行
注意新建文件夹 .ssh  
vim ~/.ssh/config 

公司办公电脑 /Users/stark/.ssh/id_rsa.pub

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDX8a/b6WCVGn2ia3Zvi+1FbTXmQtlHW9cg98PuheSeDclL/uQLTt1JNOVXEuOUXI9l0XYp6I7ZlKWJUuE1TUsrUt4QTZuUkDy6CHg4H86D7+s6PNRKOgc7atVrWFOM+lG4ANHESsFbm+L08OZbbOHUoo4ohUpuGNzqwAbMBps4D+yBUk9WQEaZUo8jHZZDvjMicD+YRWp9rSAiX9XKLUs6k7epT9q55YNZentpL71wY/X3LACT7Ob2eS46MX5SIyW0ryVIN9NccKrcCgefoBsVB7lLYTT1V/ce23KaXZHSxboaieE24tgW5ooW+EE+/bGtf7N7yyfSkLd4jfMjL/rx wsd312@163.com

服务器
vim /etc/ssh/sshd_config

Host someetmobile
        hostname 182.92.239.218
        user wsd
        Port 19422
        IdentityFile ~/.ssh/id_rsa

Host someetback
        hostname 123.56.115.212
        user wsd
        Port 19422
        IdentityFile ~/.ssh/id_rsa


更新
apt-get update

安装docker
 wget -qO- https://get.docker.com/ | sh
 安装docker-compose
 sudo pip install -U docker-compose
 
curl -L https://github.com/docker/compose/releases/download/1.10.0/run.sh > /usr/local/bin/docker-compose
 chmod +x /usr/local/bin/docker-compose
 
 daoker loggin
 
 更换 https证书
  3854  scp -P 19422 1__.someet.cc_bundle.crt 2__.someet.cc.key wsd@123.56.115.212:/home/wsd/backend/nginx/conf.d
 3855  scp -P 19422 1__.someet.cc_bundle.crt 2__.someet.cc.key wsd@182.92.239.218:/home/wsd/nginx/conf.d
 
 docker run -it --link web-mysql:mysql --rm mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'
 
  docker run -it --link some-mysql:mysql --rm mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'
