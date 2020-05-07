---
order: 10
category: 必备
title: 查看某个文件历史
---

### 查看某个文件历史

```shell
git log --pretty=oneline 文件名  # 列出文件的所有改动历史  
git show c178bf49   # 某次的改动的修改记录  
git log -p c178bf49 # 某次的改动的修改记录  
git blame 文件名     # 显示文件的每一行是在那个版本最后修改。  
git whatchanged 文件名  # 显示某个文件的每个版本提交信息：提交日期，提交人员，版本号，提交备注（没有修改细节）  
```
