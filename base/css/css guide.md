---
title: css权威指南
categories: "css权威指南"
---
css权威指南的一些读书笔记！

1. link元素的title属性值生成一个候选样式列表，可以提供用户选择不同的网站主题。
    ```
    <link rel="stylesheet" type="text/css" href="sheet1.css" title="Default" />
    <link rel="stylesheet" type="text/css" href="sheet2.css" title="Black" />
    <link rel="stylesheet" type="text/css" href="sheet3.css" title="Big Text" />
    ```
<!-- more -->
2. 属性选择器：
    ```
    h1[class] {color: red;}
    *[title] {color: red;}
    h1[class][href] {color: red;}
    h1[title^="bar"] {color: red;} //开头
    h1[title$="bar"] {color: red;} //结尾
    h1[title*="bar"] {color: red;} //包含
    ```
1. 选择器特殊性：（行内属性 > 内联表 > 外链表）
    1. ID属性选择器：0，1，0，0
    2. 类选择器、属性选择器或伪类：0，0，1，0
    3. 各个元素和伪元素：0，0，0，1
    4. 通配符没有特殊性：0，0，0，0
2. 行内元素：
    1. font-size控制字体大小，line-height指定文本基线之间的距离；
    2. padding, border, margin只影响行内元素宽度，不会影响行框的高度(只能通过line-height改变)
    2. (line-height - font-size) / 2的距离放在内容区的顶部和底部；
    3. 行内元素行框：内容区（字体） + 行间距；
3. 行内元素替换元素：
    1. 行内替换元素(img)(display:inline-block也表现一致)，底部对应的是行框内容框的baseline，所以一般会比行内元素高一点，对齐需要调整verticle-align;
    2. padding, border, margin会影响行框；
3. 块级元素-水平属性：width，左右margin，左右padding，左右border -> 相加等于父元素width
    1. 3个属性可以设置为auto: width，左右外边距；
    2. width和左右margin 都设置特定值，则margin-right会强制为auto；
    3. width设特定值，左右margin设置auto，则元素居中；
    4. width和左右margin都设置auto，则两个外边距都会设置为0，而width会尽可能宽；
    5. 负的外边距会使元素宽度边长；
4. 块级元素-垂直属性：height，上下margin，上下padding，左右border -> 相加等于父元素height
    1. 3个属性可以设置为auto: height，上下外边距；
    2. 上下margin设置为auto，它会自动计算为0；
    3. 垂直相邻外边距会合并；
5. 内边距、边框和外边距：
    1. 为元素的外边距、内边距设置百分数值，是相对于父元素的width计算的；
7. 颜色和背景：
    1. 前景色：color, border-color; 背景色：background-color;
    2. 背景颜色延伸到：content, padding, border; (可通过改变background-clip改变定位框)
    3. 背景延伸到：content, padding;  (可通过改变background-origin改变定位框)
    4. background-position可设置背景定位；
8. 浮动和定位：
    1. 只要是浮动，就会生成一个块级框；
    3. clear: left/right/both 制定元素的某个方向上不能出现浮动元素(向下看换行)；
    4. position: relative; 元素框偏移某个距离，但文档流中的位置不变，不影响其他元素的布局(所以可能会造成和边上的元素重叠)；
    5. position: absolute; 指定top, right, bottom, left属性，就相当于隐性地指定了元素的宽高；
    6. 上下左右居中：
        ```
        .c1 {
            height: 100px;
            width: 100px;
            background: #f3c8c8;
            position: relative;
        }
        .c2 {
            height: 50px;
            width: 50px;
            background-color: yellow; 
            position: absolute;
            left: 0;
            right: 0;
            top: 0;
            bottom: 0;
            display: inline-block;
            margin: auto;
        }
        ```
    7. 如果元素的所有值都过度限制(margin, padding, width, height, top, right, bottom, left)，则会忽略right和bottom的设置，重置为auto；
    8. position为非static的元素，z-index才会有效果；
    9. 七阶层叠水平(stacking level)：正z-index > z-index:auto/0 > inline/inline-block盒子 > float浮动盒子 > block块状水平盒子 > 负z-index > 层叠上下文background/border;
    10. 相对定位(position: relative)同时设定top和bottpm或者right和left，则bottom和right会重置为负的top和right值（或者说忽略bottom和right的值）；
9. 表布局
    1. display的值和table元素的对应：
    ```
    table -> dislplay: table;
    tr -> dislplay: table-row;
    thead -> dislplay: table-header-group;
    tbody -> dislplay: table-row-group;
    tfoot -> dislplay: table-footer-group;
    col -> dislplay: table-column;
    colgroup -> dislplay: table-column-group;
    td, th -> dislplay: table-cell;
    caption -> dislplay: table-caption;
    ```
    2. 匿名表对象：
    ```
    // css定义一种机制，可以将'遗漏的'组件作为匿名对象插入
    
    <table>
        <td>aaa</td>
        <td>bbb</td>
    </table>
    
    // ...实际中会转化为...
    
    <table>
        [anonymous table-row object start]
            <td>aaa</td>
            <td>bbb</td>
        [anonymous table-row object end]
    </table>
    ```
    3. 表层(层叠)：单元格 > 行 > 行组 > 列 > 列组 > 表
    4. 表单元格边框模型：
    ```
    // 1. 分隔边框模型 border-collapse: separate;
    border-spacing 控制单元格之间的距离
    empty-cells 处理表格中的空单元格(显示or隐藏)
    // 2. 合并边框模型 border-collapse: collapse;
    ```
    5. 表大小：
    ```
    // # 1. 宽度 
    // 1. 固定布局 table-layout: fixed;
    可手动设置表格宽度和表格单元宽度；
    不设置单元格宽度时，平分宽度；
    // 2. 自动布局 table-layout: auto;
    ```
10. 列表与生成内容
    1. 如果:before或:after选择器的主体是块级元素，则display属性只能接受值none, inline, block, marker，其他值都处理为block;  
    如果:before或:after选择器的主体是行内元素，属性display只能接受值noen和inline，所有其他值都处理为inline;
    2. content: <string> | <uri> | <attr()>  
    ```
    a[herf]:after {content: attr(herf)}
    ```
    3. 利用:before/:after 配合counter-reset和counter-increment可以做word章节小节目录的效果；
    