---
order: 30
title: 20.撤销commit
---

## 提交代码
```
git add . //添加所有文件

git commit -m "本功能全部完成"
```


#### 撤回commit
> 注意，仅仅是撤回commit操作，您写的代码仍然保留。
```
git reset --soft HEAD^
```
> HEAD^的意思是上一个版本，也可以写成HEAD~1
> 如果你进行了2次commit，想都撤回，可以使用HEAD~2



## 参数：
**--mixed**

* 不删除工作空间改动代码，撤销commit，并且撤销git add . 操作
* 这个为默认参数 git reset --mixed HEAD^ 和 git reset HEAD^ 效果是一样的。


**--soft**
* 不删除工作空间改动代码，撤销commit，不撤销git add . 

**--hard**
* 删除工作空间改动代码，撤销commit，撤销git add . 
* 注意完成这个操作后，就恢复到了上一次的commit状态。

如果commit注释写错了，只是想改一下注释，执行：
```
git commit --amend
```
进入默认vim编辑器，修改注释完毕后保存（wq!）
