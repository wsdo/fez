---
sidebarDepth: 4
pageClass: custom-code-highlight
---

#### 01.微信公众号验证文件

```php
<?php 
// 每次在开发者后台，提交验证的时候，会发送一个get请求此文件
// 检测微信接口验证的函数
function checkSignature()
{
    if (empty($_GET['echostr'])) {
      return;
    }
    file_put_contents('wx.log', serialize($_GET), FILE_APPEND);
    // 接收get请求
    $signature = $_GET["signature"];
    $timestamp = $_GET["timestamp"];
    $nonce = $_GET["nonce"];
    
    $token = 'stark';
    $tmpArr = array($token, $timestamp, $nonce);
    sort($tmpArr, SORT_STRING);
    // 把数组换成，字符串
    $tmpStr = implode( $tmpArr );
    // 使用sha1加密上面的字符串
    $tmpStr = sha1( $tmpStr );

	if( $tmpStr == $signature ){
		echo $_GET['echostr'];
	}else{
		echo 'failed';
	}
	exit;
}

checkSignature();
```
