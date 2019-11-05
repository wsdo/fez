---
title: css揭秘 note
date: 2018-06-03
categories: "css揭秘"
tags: 
     - CSS
     - 读书笔记
---
css揭秘的一些读书笔记！

### 第一章 引言
1. 编码技巧

```CSS
/* # 1. 相互依赖的值 */
/* bad */
font-size: 20px;
line-height: 30px;
/* good  */
font-size: 20px;
line-height: 1.5;

// # 2. 颜色函数
HSLA(色调, 饱和度, 亮度, 透明度)
```

<!-- more -->

### 第二章 背景与边框
1. 半透明边框
```CSS
/* background-clip可以更改背景覆盖区域 */
border: 10px solid hsla(0, 0%, 100%, .5);
background: white;
background-clip: padding-box;
```
2. 多重边框
```
// 1. outline方案
background: yellowgreen;
border: 1px solid #655;
outline: 5px solid deeppink;

// 2. box-shadow方案
background: yellowgreen;
box-shadow: 0 0 0 10px #655,
            0 0 0 15px deeppink;
```

3. 灵活的背景定位(实现背景图和容器右下角之间留出一定的空间)

```
// 1. background-position方案 (有点像position: absolute;的定位)
background: url("code.svg") no-repeat bottom right #58a; // bottom right 提供回退方案
background-position: right 20px bottom 10px;

// 2. background-origin方案
padding: 10px 20px; (bakground-origin改变背景图的定位框)
background: url("code.svg") no-repeat bottom right #58a;
bakground-origin: content-box;

// 3. calc()方案
background: url("code.svg") no-repeat;
background-position: calc(100% - 20px) calc(100% - 10px);
```

4. 边框内圆角
```
background: tan;
border-radius: .8em;
box-shadow: 0 0 0 .6em #655; // box-shadow会变圆
outline: .6em solid #655; // 描边不会跟着圆角走，还是矩形
```
5. 条纹背景
```
// 1. 横向条纹
background: line-gradient(#fb3 50%, #58a 50%);
background-size: 100% 30px;

// 2. 竖向条纹
background: line-gradient(to right, #fb3 50%, #58a 50%);
background-size: 30px 100%;
```
6. 伪随机背景
```
// 利用最小公约数，创造重复数(最小公约数很大)很大的背景图；
height: 200px;
width: 100%;
background: hsl(20, 40%, 90%);
background-image: 
    linear-gradient(90deg, #fb3 11px, transparent 0),
    linear-gradient(90deg, #ab4 23px, transparent 0),
    linear-gradient(90deg, #655 41px, transparent 0);
background-size: 41px 100%, 61px 100%, 83px 100%;
```

### 第三章 形状
1. 自适应的椭圆
```
// 1. 全椭圆
width: 200px;
height: 200px;
border-radius: 50%;
// 2. 半椭圆
height: 200px;
width: 400px;
background: rgb(3, 92, 3);
border-radius: 100% 0 0 100% / 50%; (横轴半径 / 纵轴半径)
```
2. 平行四边形
```
// 1. transform方案 (内嵌元素，保证内容不倾斜)
<div class="backgroung">
    <p>aaa</p>
</div>

.backgroung {
    height: 200px;
    width: 400px;
    background: rgb(3, 92, 3);
    transform: skewX(-45deg);
}
.backgroung > p {
    transform: skewX(45deg);
}

// 2. 伪元素方案
<div class="backgroung">
    aaa
</div>

.backgroung {
    height: 200px;
    width: 400px;
    color: #fff;
    padding: 50px;
    position: relative;
}
.backgroung::before {
    content: '';
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    z-index: -1;
    background: rgb(3, 92, 3);
    transform: skew(-45deg);
}
```
3. 菱形图片
```
// 1. 基于变形的方案
<div class="backgroung">
    <img src="../image//icon.jpg" alt="">
</div>

.backgroung {
    height: 200px;
    width: 200px;
    transform: rotate(45deg);
    overflow: hidden;
}
.backgroung > img {
    width: 100%;
    transform: rotate(-45deg) scale(1.42);
}

// 2. 裁切路径
<img src="../image//icon.jpg" alt="">

img {
    clip-path: polygon(50% 0, 100% 50%, 50% 100%, 0 50%);
}
```
4. 切角效果
```
// 1. 渐变方案
// 直线切角
.backgroung {
    height: 200px;
    width: 200px;
    background: #58a;
    background: linear-gradient(to top left, transparent 15px, #58a 0);
}
// 也可用上面的裁剪路径方法实现

// 弧形切角
.backgroung {
    height: 200px;
    width: 200px;
    background: #58a;
    background: radial-gradient(circle at bottom right, transparent 15px, #58a 0);
}
```
5. 梯形标签页
```
.backgroung {
    height: 200px;
    width: 200px;
    color: #fff;
    position: relative;
}
.backgroung::before {
    content: '';
    position: absolute;
    top: 0; right: 0; bottom: 0; left: 0;
    z-index: -1;
    background: #58a;
    transform: scaleY(2) perspective(200px) rotateX(45deg);
    transform-origin: bottom;
}
```
6. 饼图
```
// 1. transform解决方案
.backgroung {
    height: 200px;
    width: 200px;
    background: yellowgreen;
    background-image: linear-gradient(to right, transparent 50%, #655 0);
    border-radius: 50%;
}
.backgroung::before {
    content: '';
    display: block;
    margin-left: 50%;
    height: 100%;
    border-radius: 0 100% 100% 0 / 50%;
    background: #655;
    transform-origin: left;
    transform: rotate(.1turn);
}

// 2. svg解决方案
<svg viewBox="0 0 32 32">
    <circle r="16" cx="16" cy="16"></circle>
</svg>

svg {
    width: 100px;
    height: 100px;
    transform: rotate(-90deg);
    background: yellowgreen;
    border-radius: 50%;
}
circle {
    fill: yellowgreen;
    stroke: #655;
    stroke-width: 32;
    stroke-dasharray: 38 100; // 38是扇区比例
}
```

### 第四章 视觉效果
1. 投影
```
// 单侧 (利用box-shadow的第四个属性，缩小阴影尺寸)
box-shadow: 0 5px 4px -4px black;
// 双侧
box-shadow: 5px 0 5px -5px black,
    -5px 0 5px -5px black;
// 不规则投影 (css滤镜)
filter: drop-shadow(2px 2px 10px rgba(0, 0, 0, .5));
```
2. 毛玻璃效果
```
body, .backgroung::before {
    background: url("../image/bg.jpg") 0 / cover fixed;
}
.backgroung {
    height: 400px;
    width: 600px;
    position: relative;
    background: hsla(0, 0%, 100%, .3);
    overflow: hidden;
}
.backgroung::before {
    content: '';
    position: absolute;
    top: 0; right: 0; bottom: 0; left: 0;
    z-index: -1;
    filter: blur(20px);
    margin: -30px;
}
```
3. 折角效果
```
.backgroung {
    height: 400px;
    width: 600px;
    background: #58a; 
    background: 
        linear-gradient(to left bottom, transparent 50%, rgba(0, 0, 0, .4) 0) no-repeat 100% 0 / 2em 2em,
        linear-gradient(-135deg, transparent 1.5em, #58a 0);
}
```

### 第五章 字体排印
1. 外发光文字
```
h1 {
    background: #58a;
    color: white;
    text-shadow: 0 0 .1em, 0 0 .3em;
}
```
2. 3D文字
```
h1 {
    background: #58a;
    color: white;
    text-shadow: 0 1px hsl(0, 0%, 85%),
        0 2px hsl(0, 0%, 80%),
        0 3px hsl(0, 0%, 75%),
        0 4px hsl(0, 0%, 70%),
        0 5px hsl(0, 0%, 65%),
        0 5px 10px black;
}
```

### 第六章 用户体验
1. 选择合适的鼠标光标
    - 可拖拽 move
    - 等待 progress wait
    - 文本 text
    - 可点击 pointer
    - 禁用控件 not-allowed
    - 隐藏鼠标(看视频、触摸屏) none
2. 扩大元素可点击区域
```
// 也可使用伪元素方案
border: 10px solid transparent;
background-clip: padding-box;
```
3. 自定义复选框
```
// key: 利用和checkbox相关联的label和label::before来触发相关选中事件，用:checked伪类改变label::before来实现自定义的复选框样式
<section class="input-item">
    <input type="checkbox" id="awesome">
    <label for="awesome">Awesome</label>
</section>

input[type="checkbox"] {
    position: absolute;
    clip: rect(0, 0, 0, 0);
}
input[type="checkbox"] + label::before {
    content: '\a0';
    display: inline-block;
    vertical-align: .2em;
    width: .8em;
    height: .8em;
    margin-right: .2em;
    border-radius: .2em;
    background: silver;
    text-indent: .15em;
    line-height: .65;
}
input[type="checkbox"]:checked + label::before {
    content: '\2713';
    background: yellowgreen;
}
input[type="checkbox"]:focus + label::before {
    box-shadow: 0 0 .1em .1em #58a;
}
input[type="checkbox"]:disabled + label::before {
    background: gray;
    box-shadow: noen;
    color: #555;
}
```

### 第七章 结构与布局
1. 自适应内部元素宽度(而不是父元素宽度的100%)
```
// 1. 浮动元素

// 2. display: inline-block;

// 3. width: min-content; (推荐)
<div class="backgroung">
    <img src="../image//icon.jpg" alt="">
    <p>aaaa</p>
</div>

.backgroung {
    height: 400px;
    width: min-content;
    margin: auto; // 居中
    background: yellowgreen;
}
```
2. 根据兄弟元素的数量来设置样式
```
// 1. 定量
li:first-child:nth-last-child(4),
li:first-child:nth-last-child(4) ~ li {
    /* 当列表项正好包含4项时，命中所有列表项 */
}
// 2. 范围
li:first-child:nth-last-child(n+4),
li:first-child:nth-last-child(n+4) ~ li {
    /* 当列表项至少包含4项时，命中所有列表项 */
}
li:first-child:nth-last-child(-n+4),
li:first-child:nth-last-child(-n+4) ~ li {
    /* 当列表项最多包含4项时，命中所有列表项 */
}
li:first-child:nth-last-child(n+2):nth-child(-n+6),
li:first-child:nth-last-child(n+2):nth-child(-n+6) ~ li {
    /* 当列表项包含2~6项时，命中所有列表项 */
}
```

### 第八章 过渡与动画
1. 缓动效果(模拟小球下落)
```
@keyframes bounce {
    60%, 80%, to { 
        transform: translateY(400px);
        animation-timing-function: ease-out;
    }
    70% { transform: translateY(300px); }
    90% { transform: translateY(360px); }
}
.backgroung {
    height: 100px;
    width: 100px;
    border-radius: 50%;
    margin: auto;
    background: yellowgreen;
    animation: bounce 3s ease-in;
}
```
2. 逐帧动画: step()可以把动画切分为多帧，而且整个动画会在帧与帧之前硬切；
3. 打字动画效果
```
<h1>I am test Page!</h1>

@keyframes typing {
    from { width: 0; }
}
@keyframes caret {
    50% { border-color: transparent; }
}
h1 {
    font-family: Consolas; /* 必须等宽字体 */
    width: 15ch; /* 一个字母的宽度 */
    overflow: hidden;
    white-space: nowrap;
    border-right: .05em solid;
    animation: typing 6s steps(15),
        caret 1s steps(1) infinite;
}
```
4. 状态平滑的动画(可暂停可继续的动画)
```
// 鼠标移开时，动画会暂停，而不是瞬间回到最初状态
@keyframes panoramic {
    to { background-position: 100% 0; }
}
.backgroung {
    width: 200px;
    height: 200px;
    background: url('../image/bg.jpg');
    background-size: auto 100%;
    animation: panoramic 3s linear infinite alternate;
    animation-play-state: paused;
}
.backgroung:hover {
    animation-play-state: running;
}
```
5. 沿环形路径平移的动画
```
// 1. 一般实现
<div class="backgroung">
    <div class="avatar">
        <img src="../image/icon.jpg" alt="avatar">
    </div>
</div>

@keyframes spin {
    to { transform: rotate(1turn); }
}
.backgroung {
    width: 300px;
    height: 300px;
    background: orange;
    border-radius: 50%;
    display: flex;
    align-items: flex-start;
    justify-content: center;
}
.avatar {
    animation: spin 5s infinite linear;
    transform-origin: 50% 150px;
}
.avatar > img {
    width: 40px;
    border-radius: 50%;
    margin-top: 5px;
    animation: inherit;
    animation-direction: reverse;
}

// 2. 单个元素实现
// key: transform-origin只是一个语法糖，总是可以用translate()来实现 #1 #2效果相同
// # 1
transform: rotate(30deg);
transform-origin: 200px 300px;
// # 2
transform: translate(200px, 300px)
    rotate(30deg)
    translate(-200px, -300px);
transform-origin: 0 0;

<div class="backgroung">
    <img class="avatar" src="../image/icon.jpg" alt="avatar">
</div>

@keyframes spin {
    from {
        transform: 
            rotate(0turn)
            translateY(-150px) translateY(50%)
            rotate(1turn);
    }
    to {
        transform: 
        rotate(1turn)
            translateY(-150px) translateY(50%)
            rotate(0turn);
    }
}
.backgroung {
    width: 300px;
    height: 300px;
    background: orange;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
}
.avatar{
    width: 40px;
    border-radius: 50%;
    animation: spin 5s infinite linear;
}
```