# 搭建基础的Linux环境

1. 下载docker软件安装，docker顶部图标右侧 > Preferences选项 > Docker Engine 配置参数（镜像加速）

``` json
{
  "experimental": false,
  "debug": true,
  "registry-mirrors": [
    "https://gd77gs75.mirror.aliyuncs.com"
  ],
  "builder": {
    "gc": {
      "enabled": true,
      "defaultKeepStorage": "20GB"
    }
  }
}
```

<div><img src="https://img.kaikeba.com/a/14815152501202aeci.png" /></div>

2. 下载Linux环境(ubuntu系统)，并进入ubuntu系统环境。

终端输入：

``` BASH
docker pull ubuntu
docker run -d -it --name ubuntu -p 6000:6000 ubuntu
docker attach ubuntu # 进入ubuntu系统
```

PS: 输入exit退出系统！

判断是否进入Linux系统，如图：

<div><img src="https://img.kaikeba.com/a/60325152501202kkon.png" /></div>

3. 在次进入ubuntu系统环境，终端输入：

``` BASH
docker start ubuntu
docker attach ubuntu
```
