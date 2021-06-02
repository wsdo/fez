<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [安装和卸载 nginx](#安装和卸载-nginx)
  - [安装方式](#安装方式)
  - [安装](#安装)
  - [启动](#启动)
  - [卸载](#卸载)

<!-- /code_chunk_output -->

# 安装和卸载 nginx

## 安装方式

yum **_(推荐)_**

## 安装

```sh
yum install -y nginx
```

## 启动

```sh
nginx
```

或

```sh
service nginx start
```

## 卸载

- 先停止 nginx 服务

```sh
sudo service nginx stop
```

相当于

```
sudo systemctl stop nginx.service
```

- 删除 nginx 的自动启动

```sh
chkconfig nginx off
```

> systemctl disable nginx.service

- 删除 Nginx 本地文件

```sh
# 其实在执行yum remove nginx的时候，会清理 /usr/sbin/nginx
rm -rf /usr/sbin/nginx
rm -rf /etc/nginx
rm -rf /etc/init.d/nginx
```

- yum 清理

```sh
yum remove nginx
```

---

## 其他安装方式

[其他安装方式.md](./其他安装方式.md)
