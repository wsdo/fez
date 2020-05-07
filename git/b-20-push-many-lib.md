---
order: 10
category: 必备
title: 常用操作
---

**1. 增加3个远程库地址**

```shell
git remote add origin https://github.com/wsdo/gitfe.git 
git remote set-url --add origin https://gitlab.com/wsdo/gitfe.git 
git remote set-url --add origin https://gitee.com/wsdo/gitfe.git 
```

**2. 删除其中一个 set-url 地址**

```shell
usage: git remote set-url [--push] <name> <newurl> [<oldurl>]
   or: git remote set-url --add <name> <newurl>
   or: git remote set-url --delete <name> <url>
```

`git remote set-url --delete origin https://github.com/wsdo/gitfe.git `

**3.推送代码**

```bash
git push origin master
git push -f origin master  # 强制推送  
```

**4.拉代码**

只能拉取 `origin` 里的一个url地址，这个fetch-url  
默认为你添加的到 `origin`的第一个地址  

```shell
git pull origin master   
git pull --all # 获取远程所有内容包括tag  
git pull origin next:master # 取回origin主机的next分支，与本地的master分支合并  
git pull origin next # 远程分支是与当前分支合并  

# 上面一条命令等同于下面两条命令   
git fetch origin  
git merge origin/next  
```

如果远程主机删除了某个分支，默认情况下，git pull 不会在拉取远程分支的时候，删除对应的本地分支。这是为了防止，由于其他人操作了远程主机，导致git pull不知不觉删除了本地分支。  
但是，你可以改变这个行为，加上参数 -p 就会在本地删除远程已经删除的分支。  

```shell
$ git pull -p
# 等同于下面的命令
$ git fetch --prune origin 
$ git fetch -p
```

**5.更改pull**

只需要更改config文件里，那三个url的顺序即可，fetch-url会直接对应排行第一的那个utl连接。    
