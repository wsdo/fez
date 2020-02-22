#钉钉H5微应用开发入门
###名词解释   ![]()
####企业内部应用(刚接触者先了解前三项即可)
>企业内部开发是指“开发企业内部应用”，供钉钉企业内部的人员使用。企业可以选择由企业内部的开发者进行开发，或者由企业授权定制服务商进行开发。
钉钉企业内部应用针对前端开发实现，钉钉开放平台支持小程序和H5微应用两种开发类型

####小程序开发类型
>小程序是一种全新的开发模式，让移动开发者通过简洁的前端语法写出Native级别的性能体验，并支持iOS、Android等多端部署。小程序暂不支持PC端部署，如果应用需在PC端上使用，PC端可暂时使用H5微应用开发方式。

####H5微应用开发类型
>微应用是指用H5方式开发的应用。

####CorpID
>CorpID是企业在钉钉中的标识，每个企业拥有唯一的CorpID。
####AccessToken
>AccessToken是企业自建应用或者被企业授权开通的第三方应用访问钉钉服务端开放接口的全局唯一凭证。
 正常情况下AccessToken有效期为7200秒，有效期内重复获取会返回相同的结果，并自动续期。
 
####AppKey
>AppKey是企业自建应用的唯一性标识。开发者在创建应用时，系统会自动生成。
####AppSecret
>AppSecret和AppKey在企业自建应用时一同生成，使用AppKey和AppSecret可获取AccessToken。
####UserId
>员工在当前企业内的唯一标识，也称staffId。可由企业在创建时指定，并代表一定含义比如工号，创建后不可修改。
####UnionId
>员工在当前开发者企业账号范围内的唯一标识，系统生成，固定值，不会改变。
 同一个企业员工，在不同的开发者企业账号下，是不相同的；在同一个开发者企业账号下，是唯一且不变的，例如同一个ISV开发的多个应用，或者是扫码登录等场景的多个App账号。
####Jobnumber
>员工工号，企业通讯录的字段，可为空，不一定唯一。
####AgentId
>代表企业应用ID。

###小程序开发类型H5微应用开发类型 对比
![03325131200202dyqz](https://img.kaikeba.com/03325131200202dyqz.png)

##创建应用
登录钉钉开发者后台，选择"应用开发"->"企业内部开发"->"H5微应用"，点击"创建应用"，开始创建企业自建微应用。
![81c1f427a20b](https://dingtalkdoc.oss-cn-beijing.aliyuncs.com/images/0.0.209/1569329154973-5544a26f-b48c-4300-be33-81c1f427a20b.png)

填写应用基本信息。包括应用名称、应用Logo和应用简介，选择"企业内部自主开发"，点击"下一步"。
![10b2accd5376](https://dingtalkdoc.oss-cn-beijing.aliyuncs.com/images/0.0.209/1569329163497-87b933b0-c08e-419b-8746-10b2accd5376.png)

开发模式选择“开发应用”，开发应用类型选择“微应用”，应用首页链接填写H5微应用首页url，服务器出口IP填写本企业服务器的公网IP。
![61437521347e](https://dingtalkdoc.oss-cn-beijing.aliyuncs.com/images/0.0.209/1569329175956-b65ef946-711e-4d06-a88d-61437521347e.png)

PC端首页地址填写说明，若填写此项，在钉钉PC端工作台展示该应用；若未填写则不展示。填写后PC端示例：
![6f06e4aac982](https://dingtalkdoc.oss-cn-beijing.aliyuncs.com/images/0.0.209/1568689082843-54a95737-b17c-4e35-be3a-6f06e4aac982.png)

填写完成后，点击“创建”，即可成功创建微应用。点击查看详情，可以查看生成的appKey和appSecret，获取access_token进行开发。
![6b72140dfa80](https://dingtalkdoc.oss-cn-beijing.aliyuncs.com/images/0.0.209/1572514630047-37e98f08-be10-4ff0-8c35-6b72140dfa80.png)
![f595f369a1af](https://dingtalkdoc.oss-cn-beijing.aliyuncs.com/images/0.0.209/1572514771668-ecbeeb7d-16a7-432b-9320-f595f369a1af.png)

##设置微应用(此操作一般由企业管理员设置，但是开发者也需要了解到，再告知管理员如何设置)
####设置可使用人员（即开发者或者体验者）
>企业一般会有多个员工同时参与同一个微应用项目的开发，因此在开发微应用之前，需要设置参与的人员。
 在创建微应用后，默认会将当前创建者添加到可使用范围内。若应用有多个开发者，管理员可以通过手机号码添加该应用的开发者。添加可使用范围后，工作台上展示该应用，可用于开发过程中体验与测试。
![c24e86c79027](https://dingtalkdoc.oss-cn-beijing.aliyuncs.com/images/0.0.209/1572511704995-5e08f579-54af-4614-899a-c24e86c79027.png) 
 
####设置接口权限
> 即服务端和钉钉服务的访问权限，只有在钉钉后台开通相应的接口权限，服务端才能从钉钉访问到相应到信息。


##免登流程
>免登是指用户进入应用后，无需输入钉钉用户名和密码，应用程序可自动获取当前用户身份，进而登录系统的流程。
##发布应用
>新创建的应用，应用共两种状态，分别是：1. 未发布状态：若人员在可使用范围内，可使用应用进行开发过程中体验与测试，且最多可添加20个可使用人员。2. 发布状态：可使用人员人数无限制，可根据需要设置。

当应用经过测试后，开发者可在应用发布页面发布应用，点击确认发布。如下图所示：
![20ffbf93afa7](https://dingtalkdoc.oss-cn-beijing.aliyuncs.com/images/0.0.209/1572513366392-da950a58-2cd5-478d-b62b-20ffbf93afa7.png)

应用发布成功后，可修改应用可使用范围。可见范围可以设置全部员工、部分员工或者仅限管理员，如下图所示：
![ab1e4065f324](https://dingtalkdoc.oss-cn-beijing.aliyuncs.com/images/0.0.209/1572512420653-7ca9acb3-c0ba-4f42-a887-ab1e4065f324.png)


##开始开发
###概述（JSAPI）
H5微应用JSAPI为应用提供了调用原生控件的能力，帮助开发者高效使用拍照、定位等手机系统的能力，同时可以直接使用扫一扫、分享、钉盘等钉钉特有的能力，带给微应用接近原生代码的体验。此文档面向开发者介绍钉钉JSAPI如何使用及相关注意事项。

注意：钉钉微应用PC端开发和移动端开发已经统一，均可使用下面方式进行引入调用。

###准备工作
钉钉提供了调试页面，供开发者在开发之前提前体验客户端提供的JSAPI功能。开发者打开钉钉，扫描调试页面二维码即可提前体验，详情见[JSAPI调试页面](https://wsdebug.dingtalk.com/)。

（1）使用npm安装
```
npm install dingtalk-jsapi --save
```

使用
```
import * as dd from 'dingtalk-jsapi'; // 此方式为整体加载，也可按需进行加载
```



（2）浏览器引入

    <script src="https://g.alicdn.com/dingding/dingtalk-jsapi/2.7.13/dingtalk.open.js"></script>

###JSAPI鉴权配置
钉钉提供的JSAPI有很多是手机的基础能力，对这些JSAPI的调用不需要进行鉴权（即不需要进行dd.config），只需要保证在dd.ready里面调用即可。对于一些钉钉业务相关、安全相关的JSAPI的调用，需要开发者先进行鉴权然后再调用(如何鉴权，请看下文)。

###调用JSAPI组件

特别注意：所有JSAPI组件的调用，必须在dd.ready里面执行。
调用实例：
```
dd.ready(function() {
    // dd.ready参数为回调函数，在环境准备就绪时触发，jsapi的调用需要保证在该回调函数触发后调用，否则无效。
    dd.runtime.permission.requestAuthCode({
        corpId: "corpid",
        onSuccess: function(result) {
        /*{
            code: 'hYLK98jkf0m' //string authCode
        }*/
        },
        onFail : function(err) {}
  
    });
});
```

##免登流程（实际上就是获取到用户信息）
>免登是指用户进入应用后，无需输入钉钉用户名和密码，应用程序可自动获取当前用户身份，进而登录系统的流程(获取用户信息后，建议前端缓存起来，避免多次走免登流程，因为钉钉对免登获取code码有频次限制)。

使用以下代码获取免登授权码（调用此api不需要进行鉴权，即不需要进行dd.config）。获取的免登授权码有效期5分钟，且只能使用一次

```
dd.ready(function() {
    dd.runtime.permission.requestAuthCode({
        corpId: corpId, // 企业id
        onSuccess: function (info) {
          code = info.code // 通过该免登授权码可以获取用户身份
        }
    });
});
```
####获取用户信息步骤：
* 前端获取code码，发送给服务端
* 服务端通过应用的appkey和appsecret获取access_token
* 服务端通过access_token 和 code码获取用户信息
* 再传给前端

[传送门](https://ding-doc.dingtalk.com/doc#/serverapi2/clotub)

##JSAPI鉴权
示例代码：
```
dd.config({
    agentId: agentId, //微应用ID
    corpId: corpId, //企业ID
    timeStamp: timeStamp, //生成签名的时间戳
    nonceStr: nonceStr, //生成签名的随机串
    signature: signature, //签名
    jsApiList: [ //以下是需要用到的需要签名的jsapi 接口
        'runtime.info',
        'device.notification.prompt',
        'biz.chat.pickConversation',
        'device.notification.confirm',
        'device.notification.alert',
        'device.notification.prompt',
        'biz.chat.open',
        'biz.util.open',
        'biz.user.get',
        'biz.contact.choose',
        'biz.telephone.call',
        'biz.util.uploadImage',
        'biz.ding.post']
});
```
[JSAPI总览](https://ding-doc.dingtalk.com/doc#/dev/swk0bg)

##前端调试
1、内网穿透模式
2、真机调试

####内网穿透模式
```

```


