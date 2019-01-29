---
order: 30
title: 安装
---

[官方教程](https://git-scm.com/download/linux)，在 Linux/Unix 系统中，通过工具在中安装 `git`,这种方式比较简单，便于升级卸载工具。

下面介绍在 CentOS 系统中，通过 yum 来安装 git

> **Red Hat Enterprise Linux, Oracle Linux, CentOS, Scientific Linux, et al.**
> RHEL and derivatives typically ship older versions of git. You can [download a tarball](https://www.kernel.org/pub/software/scm/git/) and build from source, or use a 3rd-party repository such as [the IUS Community Project](https://ius.io/) to obtain a more recent version of git.

官方文档说 git 在 `RHEL` 和衍生产品通常都会发布旧版本的 `git`，我们需要源码编译安装，或者使用第三方存储库（如[IUS社区项目](https://ius.io/)）。

现在我们通过，[IUS社区](https://ius.io/GettingStarted/)下载 [ius-release.rpm](https://centos7.iuscommunity.org/ius-release.rpm) 文件进行安装

```bash
# 注意下载不同的版本，本机 CentOS 7
wget https://centos7.iuscommunity.org/ius-release.rpm
# 安装rpm文件
rpm -ivh ius-release.rpm
```

查看可安装的git安装包

```bash
repoquery --whatprovides git
# git-0:1.8.3.1-13.el7.x86_64
# git2u-0:2.16.5-1.ius.centos7.x86_64
# git2u-0:2.16.2-1.ius.centos7.x86_64
# git2u-0:2.16.4-1.ius.centos7.x86_64
# git-0:1.8.3.1-14.el7_5.x86_64
```

卸载 `1.8.3` 的 `git`，安装 `2.16.5` 的 `git`

```bash
# 卸载老的版本
yum remove git
# 安装新的版本
yum install git2u
```
