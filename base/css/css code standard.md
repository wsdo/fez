---
title: CSS代码规范
categories: "CSS代码规范"
---
目标：不管有多少参与者，代码都应该像同一个人所写
声明：本规范中的一些规定无对错之分，只是为了统一风格和增加可读性

## 1 文件格式 ##

*   文件名：全部为小写字母，后缀为`.css`, `.scss`, `.less`
*   文件编码：`UTF-8`
*   换行符：`LF`
*   缩进：`Tab`
*   行末不能包含空格
*   文件以空白行结束
*   每行最大长度：`120`
*   单文件最大行数不要超过`2000`

<!-- more -->

## 2 命名 ##

*   所有命名均使用英文，除非对应的英文无法准确表述，否则禁止使用汉语拼音，尤其禁止使用汉语拼音的字母缩写
*   尽可能使命名简短，但是不要使用意义不清晰的缩写，如果有必要可以让名称长一些
*   命名使用小写字母单词和连接符`-`，不使用下划线`_`或驼峰命名


## 3 注释 ##

*   注释内容前面增加一个空格

	正确示例：
```
	// comment
	/* comment */
```

	错误示例：
```
	//comment
	/*comment*/
```

*   尽量避免行末注释

	正确示例：
```
	div {
		// comment
		margin: 0; 
	}
```

	错误示例：
```
	div {
		margin: 0; // comment
	}
```


## 4 代码格式 ##

### 4.1 选择器 ###

*   不要绑定元素类型和class

	正确示例：
```
	.error {
	}
```

	错误示例：
```
	div.error {
	}
```

*   使用双引号`""`来括住选择器中的属性值

	正确示例：
```
	input[type="checkbox"] {
	}
```

	错误示例：
```
	input[type=checkbox] {
	}
```

### 4.2 属性值 ###

*   使用双引号`""`而不是单引号`''`，尤其不要混合使用

	正确示例：
```
	html {
		font-family: "open sans", "Segoe UI", sans-serif;
	}
```

	错误示例：
```
	html {
		font-family: "open sans", 'Segoe UI', sans-serif;
	}
```

*   Hex值使用小写字母

	正确示例：
```
	color: #fafafa;
```

	错误示例：
```
	color: #FAFAFA;
```

*   Hex值如果能简写则简写

	正确示例：
```
	color: #ccc;
	color: #ebc;
```

	错误示例：
```
	color: #cccccc;
	color: #eebbcc;
```

*   数值为0避免使用单位

	正确示例：
```
	margin: 0;
```

	错误示例：
```
	margin: 0px;
```

### 4.3 换行 ###

*   规则声明后面大括号`}`独占一行

	正确示例：
```
	div {
		margin: 0;
	}
```

	错误示例：
```
	div {
		margin: 0;}
```

*   在一个规则声明中使用了多个选择器时，每个选择器独占一行

	正确示例：
```
	h1,
	h2,
	h3 {
		margin: 0;
	}
```

	错误示例：
```
	h1, h2, h3 {
		margin: 0;
	}
```

*   对于以逗号分隔并且非常长的属性值, 可以放在多行中

	正确示例：
```
	.selector {
    	box-shadow:
        	1px 1px 1px #000,
        	2px 2px 1px 1px #ccc inset;
    	background-image:
        	linear-gradient(#fff, #ccc),
        	linear-gradient(#f3c, #4ec);
	}
```

	错误示例：
```
	.selector {
    	box-shadow:
        	1px 1px 1px #000, 2px 2px 1px 1px #ccc inset;
    	background-image:
        	linear-gradient(#fff, #ccc), linear-gradient(#f3c, #4ec);
	}
```

*   每个属性声明放在单独的行中，即使只有一个属性

	正确示例：
```
	.selector {
		width: 10%;
	}
```

	错误示例：
```
	.selector { width: 10%; }
```

### 4.4 空行 ###

*   两个规则之间使用一个空行

	正确示例：
```
	.s1 {
	  margin: 0;
	}

	.s2 {
	  margin: 0;
	}
```

	错误示例：
```
	.s1 {
	  margin: 0;
	}
	.s2 {
	  margin: 0;
	}
```

### 4.5 空格 ###

*   在规则声明的左大括号`{`前加一个空格

	正确示例：
```
	h3 {
	  font-weight: bold;
	}
```

	错误示例：
```
	h3{
	  font-weight: bold;
	}
```

*   属性名的冒号后面加一个空格，前面不加空格

	正确示例：
```
	h3 {
	  font-weight: bold;
	}
```

	错误示例：
```
	h3 {
	  font-weight:bold;
	}
```

*   逗号分隔的值，在逗号后加一个空格

	正确示例：
```
	div {
	  color:rgba(0, 0, 0, .5);
	}
```

	错误示例：
```
	div {
	  color:rgba(0,0,0,.5);
	}
```

*   连接符前后各加一个空格

	正确示例：
```
	li > p {
		margin-top: 0;
	}

	li + li {
		margin-top: 0;
	}
```

	错误示例：
```
	li>p {
		margin-top: 0;
	}

	li+li {
		margin-top: 0;
	}
```


## 5 编程惯例 ##

*   不要使用ID选择器
*   避免在CSS和JavaScript中绑定相同的class。用于特定JavaScript的类名时，添加`.js-`前缀
*   LESS/SCSS中不要让嵌套选择器的深度超过3层
*   LESS/SCSS中把一些公共的样式代码抽象成变量，例如：颜色
*   把相关的属性放一起，比如把position相关的属性放一起
*   按位置，盒模型，文字, 外观，其他，来组织属性声明顺序
*   尽量将媒体查询的位置靠近它们相关的规则。不要将它们放到一个独立的样式文件中，或者放在文档的最底部
*   按不同的组件(component)来拆分不同的样式文件，而不是按页面来拆分
