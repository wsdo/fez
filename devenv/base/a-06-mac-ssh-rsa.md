---
order: 29
category: mac
title: 本地生成 rsa 公钥，ssh
---

本地生成 rsa 公钥，ssh ，添加到GitHub ssh key
```
ssh-keygen -t rsa -C "wsd312@163.com"
```
一路回车

```
cat /Users/stark/.ssh/id_rsa.pub
```
