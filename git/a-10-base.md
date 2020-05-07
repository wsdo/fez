---
order: 10
category: 必备
title: 常用操作
---

## 添加代码
> 你可以提出更改（把它们添加到暂存区），使用如下命令：
```
git add <filename>
git add .
```
> 这是 git 基本工作流程的第一步；使用如下命令以实际提交改动：

## 提交代码
```
git commit -am"feat: 本次更改的内容"
```
```
zshell简洁操作： gc -am"feat: 本次更改的内容"
```
> 现在，你的改动已经提交到了 HEAD，但是还没到你的远端仓库。

## 推送改动
> 你的改动现在已经在本地仓库的 HEAD 中了。执行如下命令以将这些改动提交到远端仓库：

```
git push origin master
```
> 可以把 master 换成你想要推送的任何分支。

```
zshell简洁操作： ggpush
```

> 如果你还没有克隆现有仓库，并欲将你的仓库连接到某个远程服务器，你可以使用如下命令添加：
```
git remote add origin <server>
```

如此你就能够将你的改动推送到所添加的服务器上去了。
分支是用来将特性开发绝缘开来的。在你创建仓库的时候，master 是“默认的”分支。在其他分支上进行开发，完成后再将它们合并到主分支上。


创建一个叫做“feature_x”的分支，并切换过去：
```
git checkout -b feature_x
```
切换回主分支：
```
git checkout master
```

再把新建的分支删掉：
```
git branch -d feature_x
```
除非你将分支推送到远端仓库，不然该分支就是 不为他人所见的：
git push origin <branch>
