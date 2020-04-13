---
title: Linux用户管理
categories: "Linux-user"
---

## 添加用户

```
useradd username
```
**demo**
> 添加一个用户名为stark的用户
```
useradd stark
```

## 创建用户家目录
```
mkdir -p /home/stark
```

## 为用户添加家目录
```
chown -R stark:stark /home/stark
```

## 为刚才添加的用户，授权于sudo权限
```
gpasswd -a stark sudo
```

#### 设置用户密码
```
passwd stark
usermod -s /bin/bash stark
```

## 为用户设置docker权限
```
usermod -a -G docker stark
```

## 为用户设置bash
```
usermod -s /bin/bash stark
```

## 为用户设置密码
```
passwd stark
```
