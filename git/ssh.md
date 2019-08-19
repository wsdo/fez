---
sidebarDepth: 4
pageClass: custom-code-highlight
---

## ssh 
这个密钥用来跟 github 通信，在本地终端里生成然后上传到 github

```bash
ssh-keygen -t rsa -C 'wsd312@163.com' # 生成密钥
ssh-keygen -t rsa -C "wsd312@163.com" -f ~/.ssh/ww_rsa # 指定生成目录文件名字
ssh -T git@github.com # 测试是否成功
```
## 然后
```
cat ~/.ssh/id_rsa.pub
查看了放在GitHub 仓库上面
```
