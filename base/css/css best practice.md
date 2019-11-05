---
title: CSS最佳实践
categories: "CSS最佳实践"
---
基于网易NEC的一个CSS实践方案
*reference: http://nec.netease.com/*

## 1. 项目初始reset
    ```
    /* reset.less */
    html,body,h1,h2,h3,h4,h5,h6,div,dl,dt,dd,ul,ol,li,p,blockquote,pre,hr,figure,table,caption,th,td,form,fieldset,legend,input,button,textarea,menu{margin:0;padding:0;}
    header,footer,section,article,aside,nav,hgroup,address,figure,figcaption,menu,details{display:block;}
    table{border-collapse:collapse;border-spacing:0;}
    caption,th{text-align:left;font-weight:normal;}
    html,body,fieldset,img,iframe,abbr{border:0;}
    i,cite,em,var,address,dfn{font-style:normal;}
    [hidefocus],summary{outline:0;}
    li{list-style:none;}
    h1,h2,h3,h4,h5,h6,small{font-size:100%;}
    sup,sub{font-size:83%;}
    pre,code,kbd,samp{font-family:inherit;}
    q:before,q:after{content:none;}
    textarea{overflow:auto;resize:none;}
    label,summary{cursor:default;}
    a,button{cursor:pointer;}
    h1,h2,h3,h4,h5,h6,em,strong,b{font-weight:bold;}
    del,ins,u,s,a,a:hover{text-decoration:none;}
    body,textarea,input,button,select,keygen,legend{font:12px/1.14 arial,\5b8b\4f53;color:#333;outline:0;}
    body{background:#fff;}
    a,a:hover{color:#333;}
    ```
<!-- more -->

## 2. css命名规则

- **分类的命名方法：使用单个字母+"-"为前缀**
布局（grid）（.g-）；
模块（module）（.m-）； >  元件（unit）（.u-）；
功能（function）（.f-）；
状态（.z-）。
皮肤（skin）（.s-）；

- **统一语义理解和命名**

    1. *布局（.g-）*
        语义 | 命名 | 简写
        --- | --- | ---
        文档|	doc|	   doc
        头部|	head|	hd
        主体|	body|	bd
        尾部|	foot|	ft
        主栏|	main|	mn
        主栏子容器|	mainc|	mnc
        侧栏|	side|	sd
        侧栏子容器|	sidec|	sdc
        盒容器|	wrap|/box	wrap/box

    2. *模块（.m-）、元件（.u-）*
        语义|	命名|	简写
        --- | --- | ---
        导航|	nav|	nav
        子导航|	subnav|	snav
        面包屑|	crumb|	crm
        菜单|	menu|	menu
        选项卡|	tab|	tab
        标题区|	head/title|	hd/tt
        内容区|	body/content|	bd/ct
        列表|	list|	lst
        表格|	table|	tb
        表单|	form|	fm
        热点|	hot|	hot
        排行|	top|	top
        登录|	login|	log
        标志|	logo|	logo
        广告|	advertise|	ad
        搜索|	search|	sch
        幻灯|	slide|	sld
        提示|	tips|	tips
        帮助|	help|	help
        新闻|	news|	news
        下载|	download|	dld
        注册|	regist|	reg
        投票|	vote|	vote
        版权|	copyright|	cprt
        结果|	result|	rst
        标题|	title|	tt
        按钮|	button|	btn
        输入|	input|	ipt

    3. *功能（.f-）*
        语义|	命名|	简写
        --- | --- | ---
        浮动清除 |	clearboth |	cb
        向左浮动 |	floatleft |	fl
        向右浮动 |	floatright |	fr
        内联块级 |	inlineblock |	ib
        文本居中 |	textaligncenter |	tac
        文本居右 |	textalignright |	tar
        文本居左 |	textalignleft |	tal
        垂直居中 |	verticalalignmiddle |	vam
        溢出隐藏 |	overflowhidden |	oh
        完全消失 |	displaynone |	dn
        字体大小 |	fontsize |	fs
        字体粗细 |	fontweight |	fw

    4. *皮肤（.s-）*
        语义|	命名|	简写
        --- | --- | ---
        字体颜色 |	fontcolor |	fc
        背景 |	background |	bg
        背景颜色 |	backgroundcolor |	bgc
        背景图片 |	backgroundimage |	bgi
        背景定位 |	backgroundposition |	bgp
        边框颜色 |	bordercolor |	bdc

    5. *状态（.z-）*
        语义|	命名|	简写
        --- | --- | ---
        选中 |	selected |	sel
        当前 |	current |	crt
        显示 |	show |	show
        隐藏 |	hide |	hide
        打开 |	open |	open
        关闭 |	close |	close
        出错 |	error |	err
        不可用 |	disabled |	dis


## 3. css工具类

- **css layout.css**: 布局(参考代码库)

- **css function.css**: 工具（居中方法等）==也许提取成less/sass函数会更好==

- **css media.css**: 媒体查询
    ```
    /* media */
    /* 横屏 */
    @media screen and (orientation:landscape){
    }
    /* 竖屏 */
    @media screen and (orientation:portrait){
    }
    /* 窗口宽度<960,设计宽度=768 */
    @media screen and (max-width:959px){
    }
    /* 窗口宽度<768,设计宽度=640 */
    @media screen and (max-width:767px){
    }
    /* 窗口宽度<640,设计宽度=480 */
    @media screen and (max-width:639px){
    }
    /* 窗口宽度<480,设计宽度=320 */
    @media screen and (max-width:479px){
    }
    /* windows UI 贴靠 */
    @media screen and (-ms-view-state:snapped){
    }
    /* 打印 */
    @media print{
    }
    ```
- **css animation.css**: 常用动画(参考代码库)
    ```
    /* animation 示例 */
    /* 淡入 */
    .a-fadein{-webkit-animation-name:fadein;-moz-animation-name:fadein;-ms-animation-name:fadein;animation-name:fadein;}
    /* define */
    /* 淡入 */
    @-webkit-keyframes fadein{
        0%{opacity:0;}
        100%{opacity:1;}
    }
    @-moz-keyframes fadein{
        0%{opacity:0;}
        100%{opacity:1;}
    }
    @-ms-keyframes fadein{
        0%{opacity:0;}
        100%{opacity:1;}
    }
    @keyframes fadein{
        0%{opacity:0;}
        100%{opacity:1;}
    }
    ```
