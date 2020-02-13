---
title: koa入门
categories: "koa"
---

## 概念
> Koa是基于 Node.js 平台的web开发框架，体积小，但扩展性强。通过利用async函数，帮你丢弃回调函数，增强错误处理。

### 开发环境搭建
#### 安装node.js
koa2开发要求Node.js版本高于v7.6
查看Node版本方法（windows版本）：
```node -v```
#### 搭建环境
建立项目文件夹

```cd code  //进入code文件夹```
```mkdir koa //创建koa文件夹```
```cd koa  //进入koa文件夹```

进入项目文件夹之后，我们初始化生产package.json文件

```npm init -y```

生成package.json之后，安装koa包

```npm install --save koa```


环境搭建完成之后，我们来写第一个小demo练习一下～
在文件夹根目录下新建index.js文件：

```
const Koa = require('koa');
const app = new Koa();

app.use(async ( ctx )=>{
  ctx.body = 'hello koa'
})

app.listen(3000)

```

编写完成后在命令行输入：
```node index.js ```

然后在浏览器中打开 http://127.0.0.0:3000 就可以看到展示的结果了～

![运行效果](https://img.kaikeba.com/mall/804131200202dlfl.png)


#### async/await的使用
由于koa2 基于node7.6版本后引入的使用async和await来实现异步，所以我们先了解以下async及await的基础概念

async是声明一个方法是异步的，await是等待异步方法完成。 需要注意的是await必须在async方法中才可以使用，因为await访问本身就会造成程序停止阻塞，所以必须在异步方法中才可以使用。

eg:
```
function takeLongTime(){
  return new Promise(resolve => {
    setTimeout(() => resolve("long_time_value", 1000))
  })
}
async function test(){
  const v = await takeLongTime();
  console.log(v);
}

test();
```

### app.listen(...)
Koa应用程序不是HTTP服务器1对1展现，可以将一个或者多个Koa应用安装在一起形成单个HTTP服务器的更大应用程序。
以下内容是指一个无作用的Koa应用程序绑定到3000指定端口：
```
  const Koa = require('koa');
  const app = new Koa();
  app.listen(3000);
```
这里的app.listen()语法糖的详细方法为：
```
  const http = require('http');
  const Koa = require('koa');
  const app = new Koa();
  http.createServer(app.callback()).listen(3000);
```
这也就意味着我们可以将同一个应用程序同时作为HTTP和HTTPS或者多个地址
eg:
```
  const http = require('http');
  const https = require('https');
  const Koa = require('koa');
  const app = new Koa();
  http.createServer(app.callback()).listen(3000);
  https.createServer(app.callback()).listen(3001);
```

#### Get请求的接收
在前后端配合时，后端一般会告知我们请求时的GET/POST请求，接下来我们看一下Koa2如何接收并处理数据的：
在Koa2中GET请求通过request接收，接收方法有两种： query和querystring。
query： 返回格式化好的参数对象。
querystring： 返回请求字符串。

eg:

demo1.js
```
  const Koa = require('koa');
  const app = new Koa();
  app.use(async(ctx)=>{
      let url =ctx.url;
      let request =ctx.request;
      let req_query = request.query;
      let req_querystring = request.querystring;

      ctx.body={
          url,
          req_query,
          req_querystring
      }

  });

  app.listen(3000,()=>{
      console.log('[demo] server is starting at port 3000');
  });
```
编写好后，在终端中使用node demo1.js启动服务。启动一切正常可在浏览器中使用,我们可以看到获取到的数据。
![运行结果](https://img.kaikeba.com/mall/525131200202dfgq.png)
图片中我们可以看到query是一个对象，而querystring就是一个普通的字符串

##### 直接从ctx中获取Get请求

除了在ctx.request中获取Get请求外，还可以直接在ctx中得到GET请求。ctx中也分为query和querystring。接着上边的代码，我们看一下在ctx下直接获取GET请求的方式。
```
const Koa = require('koa');
const app = new Koa();
app.use(async(ctx)=>{
    let url =ctx.url;

    //从request中获取GET请求
    let request =ctx.request;
    let req_query = request.query;
    let req_querystring = request.querystring;

    //从上下文中直接获取
    let ctx_query = ctx.query;
    let ctx_querystring = ctx.querystring;

    ctx.body={
        url,
        req_query,
        req_querystring,
        ctx_query,
        ctx_querystring
    }

});

app.listen(3000,()=>{
    console.log('[demo] server is starting at port 3000');
});
```

总结：获得GET请求的方式有两种，一种是从request中获得，一种是一直从上下文中获得。获得的格式也有两种：query和querystring。


#### POST请求的接收

获取Post请求的步骤：
> 解析上下文ctx中的原生nodex.js对象req。
> 将POST表单数据解析成query string-字符串.(eg:user=hxy&age=18)
> 将字符串转换成JSON格式。

ctx.request和ctx.req的区别：
> ctx.request是Koa2中context经过封装的请求对象。
> ctx.req是context提供的node.js原生HTTP请求对象。

ctx.method 得到请求类型
> Koa2中提供了ctx.method属性，可以轻松的得到请求的类型，然后根据请求类型编写不同的相应方法。
eg:
GET请求时得到表单填写页面，POST请求时，得到POST处理页面。

```
const Koa = require('koa');
const app = new Koa();
app.use(async(ctx)=>{
    //当请求时GET请求时，显示表单让用户填写
    if(ctx.url==='/' && ctx.method === 'GET'){
        let html =`
            <h1>Koa2 request post demo</h1>
            <form method="POST"  action="/">
                <p>userName</p>
                <input name="userName" /> <br/>
                <p>age</p>
                <input name="age" /> <br/>
                <p>webSite</p>
                <input name='webSite' /><br/>
                <button type="submit">submit</button>
            </form>
        `;
        ctx.body =html;
    //当请求时POST请求时
    }else if(ctx.url==='/' && ctx.method === 'POST'){
        ctx.body='接收到请求';
    }else{
        //其它请求显示404页面
        ctx.body='<h1>404!</h1>';
    }
})

app.listen(3000,()=>{
    console.log('[demo] server is starting at port 3000');
})
```


#### koa-bodyparser中间件
对于POST请求的处理，koa-bodyparser中间件可以把koa2上下文的formData数据解析到ctx.request.body中

安装中间件
```
npm install --save koa-bodyparser@3
```
引入使用
```
const bodyParser = require('koa-bodyparser');

app.use(bodyParser());
```

在代码使用中，可以直接使用ctx.request.body进行获取POST请求参数，中间件自动做解析。

eg: 
```
const Koa = require('koa');
const app = new Koa();

const bodyParesr = require('koa-bodyparser');
app.use(bodyParser());

app.use(async(ctx)=>{
    if(ctx.url==='/' && ctx.method==='GET'){
        //显示表单页面
        let html=`
            <h1>JSPang Koa2 request POST</h1>
            <form method="POST" action="/">
                <p>userName</p>
                <input name="userName" /><br/>
                <p>age</p>
                <input name="age" /><br/>
                <p>website</p>
                <input name="webSite" /><br/>
                <button type="submit">submit</button>
            </form>
        `;
        ctx.body=html;
    }else if(ctx.url==='/' && ctx.method==='POST'){
         let postData= ctx.request.body;
         ctx.body=postData;
    }else{
        ctx.body='<h1>404!</h1>';
    }

});

app.listen(3000, ()=>{
  console.log('3000~')
})

```





