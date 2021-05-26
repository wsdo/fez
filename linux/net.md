# 网络操作
## 网络检测

- ifconfig 检测网络接口配置

`ifconfig`

- ping 检测网络连通性

如果没有`ping`命令，可以执行`apt install iputils-ping`安装
```shell
# -c 发送2条之后停止进行检测
ping -c 2 59.110.247.22
```
- host/dig/nslookup检测DNS解析

  `apt install dnsutils`
    ```shell
  # 查看baidu在本机的DNS
    dig baidu.com
    host baidu.com
    ```
  nslookup允许交互式查询
  ```shell
  nslookup
  ```
- wget 下载文件
  ```shell
  wget https://img.kaikeba.com/518112501202cubo.jpg?imageView2/2/w/375/format/webp
  # -r 递归下载
  # -l 递归的最大深度
  # -c 断点续传
  # -p 下载html中相关的图片等元素
  wget -c -r --level=1 -p -np http://docs.Python.org/2/tutorial/index.html
  # 下载重命名
  wget -O png.png https://img.kaikeba.com/518112501202cubo.jpg?imageView2/2/w/375/format/webp
  # 重试40次
  wget --tries=40 http://192.168.1.10/abc.zip
  ```
- ssh/scp 远程链接/远程复制
  
  ssh [参数][主机]
  
  常用参数
  
  -p 端口
  
  -i 身份验证文件
  
  -l 登录名
