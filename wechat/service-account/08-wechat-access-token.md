---
sidebarDepth: 4
pageClass: custom-code-highlight
---

## 08.微信网页授权
```
<?php
echo '去access文件里面找这个项目';die;
require('conf.php');
require('Curl.php');
function get_curl($url) {
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_POST, false);
    curl_setopt($curl, CURLOPT_USERAGENT, 'User-Agent: Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 2.0.50727; .NET CLR 3.0.04506.648; .NET CLR 3.5.21022)');
    curl_setopt($curl, CURLOPT_TIMEOUT, 10);
    curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    $result = curl_exec($curl);
    curl_close($curl);
    return $result;
}

$code = $_GET['code'];
if (empty($code)) {
    echo 'user not permissioned';
    exit;
} else {
    echo $code;
}

// 第二步：通过code换取网页授权access_token
// 获取code后，请求以下链接获取access_token：  
//      https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code 
$url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid={$appid}&secret={$appsecret}&code={$code}&grant_type=authorization_code";
echo '</br></br>';
// echo $url;

$cont = Curl::CurlGet($url);
// $cont = get_curl($url);
// var_dump($cont);
$cont = (array)json_decode($cont);
// var_dump($cont);

// 第四步：拉取用户信息(需scope为 snsapi_userinfo)
// 如果网页授权作用域为snsapi_userinfo，则此时开发者可以通过access_token和openid拉取用户信息了。
// 请求方法
// http：GET（请使用https协议） 
//      https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN 
$url = "https://api.weixin.qq.com/sns/userinfo?access_token={$cont['access_token']}&openid={$cont['openid']}&lang=zh_CN";
$cont = Curl::CurlGet($url);
$user = (array)json_decode($cont);
var_dump($user);

```
