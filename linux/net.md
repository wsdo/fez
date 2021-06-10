# 网络操作

#### ifconfig 检测网络接口配置

如果没有命令，则使用
```shell
apt install net-tools
```
进行安装

```shell
# 查看网络状况
ifconfig
# 开启和关闭网卡
ifconfig eth0 up
ifconfig eth0 down
# 显示所有网络接口
ifconfig -a
```

结果解析：



#### ping 检测网络连通性

如果没有`ping`命令，可以执行`apt install iputils-ping`安装
```shell
# -c 发送2条之后停止进行检测
ping -c 2 59.110.247.22
# 指定间隔秒数
ping -i 1 59.110.247.22
```
#### host/dig/nslookup 检测DNS解析
是常用的域名查询工具，可以用来测试域名系统工作是否正常。
  
  `apt install dnsutils`

  ```shell
  # 查看baidu的DNS配置
  dig baidu.com
  dig -x 
  host baidu.com
  ```
  nslookup允许交互式查询
  ```shell
  nslookup
  ```
#### wget 下载文件
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
#### ssh 远程链接
  
  ssh [参数][主机]
  
  常用参数
  
  -p 端口
  
  -i 身份验证文件
  
  -l 登录名
#### scp 远程传递文件
scp [选项] 源文件 目标文件
  
常用选项
```shell
-F 指定ssh配置文件
-r 以递归方式复制
```
```shell
#从 10.10.10.10 机器上的/opt/soft/的目录中下载 nginx-0.5.38.tar.gz  文件到本地/opt/soft/目录中。
scp root@10.10.10.10:/opt/soft/nginx-0.5.38.tar.gz /opt/soft/
#上传本地文件到远程机器指定目录
scp /opt/soft/nginx-0.5.38.tar.gz root@10.10.10.10:/opt/soft/scptest
```

