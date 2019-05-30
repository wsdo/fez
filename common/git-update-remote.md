---
order: 41
category: git
title: 修改远程仓库地址
---

#### 有两中方式

##### 方式1：
```bash
git remote remove origin  # 删除该远程路径
git remote add origin git@wsdo.github.com:wsdo/fe.git  # 添加远程路径
```
##### 方式2：

```
git remote set-url origin https://gitlab.com/wsdo/fe.git
```
