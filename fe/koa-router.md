---
title: koa入门
categories: "koa"
---

#### koa路由实现

##### 原生路由实现
实现原生路由，需要得到地址栏输入的路径，然后根据路径的不同进行跳转。
在koa中，使用ctx.request.url就可以获取到当前页面的路径
eg:
```
  const Koa = require('koa')
  const app = new Koa()

  app.use( async ( ctx ) => {
    let url = ctx.request.url
    ctx.body = url
  })
  app.listen(3000)
```
![20200215143828](http://f.shudong.wang/huangxiangyang/20200215143828.png)
原生路由的实现需要引入fs模块来读取文件。然后再根据路由的路径去读取，最后返回给页面，进行渲染。
eg:
```
const Koa = require('koa');
const fs = require('fs');
const app = new Koa();

function render(page){
    return  new Promise((resolve,reject)=>{
        let pageUrl = `./page/${page}`;
        fs.readFile(pageUrl,"binary",(err,data)=>{
            if(err){
                reject(err)
            }else{
                resolve(data);
            }
        })
    })
}

async function route(url){
    let page = '404.html';
    switch(url){
        case '/':
            page ='index.html';
            break;
        case '/index':
            page ='index.html';
            break;
        case '/404':
            page = '404.html';
            break;
        default:
            break; 
    }
    let html = await render(page);
    return html;
}

app.use(async(ctx)=>{
    let url = ctx.request.url;
    let html = await route(url);

    ctx.body=html;
})
app.listen(3000);
```

##### Koa-router中间件
安装方法：
```
npm install --save koa-router
```
安装完成后，我们来试一下基础使用方法：
```
const Koa = require('koa');
// 引入中间件
const Router = require('koa-router');

const app = new Koa();
const router = new Router();
// 127.0.0.1:3000
router
    .get('/', (ctx, next)=>{
        ctx.body = 'hello, koa-router'
    })
//路由装载
app
    .use(router.routes())
    .use(router.allowedMethods()); //遵循上文get请求

app.listen(3000, ()=>{
    console.log('3000')
})
```
![20200217142634](http://f.shudong.wang/huangxiangyang/20200217142634.png)
多页面配置方法：
```
router.get('/', function (ctx, next) {
    ctx.body="Hello1";
})
.get('/index',(ctx,next)=>{
    ctx.body="hello2"
});
```

##### 路由层级
工作中我们有时候会碰到需要在整个项目的路径中添加一个整体的路由前缀，比如127.0.0.1:3000/index/a, 127.0.0.1:3000/index/b, index就是我们需要统一添加的层级前缀，也就是说，这个路由的所有请求都是相对于这个前缀的。
这里，我们需要给Router添加一个prefix属性：
```
const router = new Router({
    prefix:'/index'
})
```
prefix属性设置'/index'，表示我们的访问路径加了一个层级index。
我们来看一下效果：
```
const router = new Router({
  prefix: '/index'
});

router
.get('/', (ctx, next)=>{
    ctx.body = 'hello, koa-router'
})
.get('/a', (ctx, next)=>{
  ctx.body = 'hello, indexa'
})
app
    .use(router.routes())
    .use(router.allowedMethods()); //遵循上文get请求

app.listen(3000, ()=>{
    console.log('3000')
})
```
![20200217143704](http://f.shudong.wang/huangxiangyang/20200217143704.png)
![20200217143717](http://f.shudong.wang/huangxiangyang/20200217143717.png)

设置前缀一般都是全局的，并不能实现个别路由的层级，如果你想为单个页面设置层级，只要在use时使用路径就可以了。

我们给不同的路由添加层级，首先，声明两个路由，一个是home，一个是page，然后通过use来赋予不同的前层级。

例子：
```
const Koa = require('koa');
const app = new Koa();
const Router = require('koa-router');

let home = new Router(); // 子路由home
home.get('/a', (ctx)=>{
    ctx.body = 'Home a';
}).get('/b', (ctx)=>{
    ctx.body = 'Home b';
})

let page = new Router(); // 子路由page
page.get('/a', (ctx)=>{
    ctx.body = 'Page a';
}).get('/b', (ctx)=>{
    ctx.body = 'Page b';
})

//通过父级路由router装载所有子路由
let router = new Router();
router.use('/home',home.routes(),home.allowedMethods());
router.use('/page',page.routes(),page.allowedMethods());

//将父级路由router加载到app路由中间件上
app.use(router.routes()).use(router.allowedMethods());

app.listen(3000,()=>{
    console.log('3000')
});
```
![20200217145633](http://f.shudong.wang/huangxiangyang/20200217145633.png)
![20200217145654](http://f.shudong.wang/huangxiangyang/20200217145654.png)

##### 路由传递参数
koa中，我们可以通过ctx.query来获取路由中传递的参数。
```
router.get('/', function (ctx, next) {
    ctx.body=ctx.query;
});
```
![20200217155947](http://f.shudong.wang/huangxiangyang/20200217155947.png)
