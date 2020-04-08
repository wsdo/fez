---
order: 27
category: mac
title: 安装nginx环境
---

#### 安装nginx环境
```
brew install nginx
```

## nginx info
```
nginx
Docroot is: /usr/local/var/www

The default port has been set in /usr/local/etc/nginx/nginx.conf to 8080 so that
nginx can run without sudo.

nginx will load all files in /usr/local/etc/nginx/servers/.

To have launchd start nginx now and restart at login:
  brew services start nginx
Or, if you don't want/need a background service you can just run:
  nginx
```

## 启动nginx方式

```
brew services start nginx

or

sudo nginx
```

## nginx 运行的根目录
```
/usr/local/var/www
```
## 修改配置

```
/usr/local/etc/nginx/servers/
```
> 修改完成，重启
```
sudo nginx -s  reload

修改成功了
```

## 安装成功
http://localhost:8080/
```
Welcome to nginx!
If you see this page, the nginx web server is successfully installed and working. Further configuration is required.

For online documentation and support please refer to nginx.org.
Commercial support is available at nginx.com.

Thank you for using nginx.
```

