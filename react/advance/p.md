---
title: react性能
categories: "react"
---
react性能！


### 渲染原理

*参考:   
    [1. 从渲染原理到性能优化](https://zhuanlan.zhihu.com/p/44331138)  
    [2. React性能优化-虚拟Dom原理浅析](https://segmentfault.com/a/1190000015366521)*

1. JSX代码经过babel编译之后变成React.createElement的表达式，这个表达式在ReactDOM.render函数被调用的时候执行生成一个element；
2. 在首次渲染的时候，先去按照规则初始化element，接着ReactComponentComponentWrapper通过递归，最终调用ReactDOMComponent的mountComponent方法来帮助生成真实DOM节点；
3. mountComponent中就用document.createElement, appendChild等原生API来生成DOM并插入文档中；  
<!-- more -->
```JavaScript
// 1. jsx
<div className='cn'>
  Content!
</div>
// 2. react转义
React.createElement(
  'div',
  { className: 'cn' },
  'Content!'
);
// 3. virtual DOM
{
  type: div,
  props: {
    className: cn,
    children: [
      'Content 1!',
    ]
  },
}
// 4. render
ReactDOM.render(
  React.createElement( 'div', { className: 'cn' }, 'Content!' ), // "creating" a component
  document.getElementById('#root') // inserting it on a page
);
```

### React 16 加载性能优化指南

*参考: [React 16 加载性能优化指南](http://imweb.io/topic/5b6cf66c93759a0e51c917c7)*

1. 首屏 -> 避免空白：在app root节点中加入loading提示；
2. 首屏 -> 内容渲染：
    1. 可优化资源：
        1. 基础框架：如 React、Vue 等，这些基础框架的代码是不变的，除非升级框架；
        2. Polyfill：对于使用了 ES2015+ 语法的项目来说，为了兼容性，polyfill 是必要的存在；
        3. 业务基础库：业务的一些通用的基础代码，不属于框架，但大部分业务都会使用到；
        4. 业务代码：特点是具体业务自身的逻辑代码；
    2. 缓存基础框架：制定合适的缓存策略，四种缓存的优先级：cache-control > expires > etag > last-modified；
    3. 使用动态 polyfill：
        1. 去掉构建中静态的 polyfill，换而使用 polyfill.io 这样的动态 polyfill 服务，保证只有在需要时，才会引入 polyfill；
        2. 编译到 ES2015+ ，提升代码运行效率，利用《script type="module"》标签检测是否支持信语法；
        ```HTML
        <script type="module" src="main.es2016.js；"></script>
        <script nomodule src="main.es5.js"></script>
        // 1. 新浏览器识别module和nomodule，会只加载main.es2016.js；
        // 2. 旧浏览器不识别module和nomodule，会只加载main.es5.js；
        ```
    4. 使用 SplitChunksPlugin 自动拆分业务基础库；
    5. 业务代码：
        1. 使用 Tree Shaking 减少业务代码体积，去除没有用到的代码；
        2. Code Splitting “懒加载”代码，改成动态import的形式(React Loadable组件)；
        3. shouldComponent()避免不必要的diff；或者启用PureComponent，自带shouldComponent浅比较props和state；
        4. list类型的同级节点加key属性；
    6. 页面图片懒加载：监听scroll(节流)；
    
### React 框架级别性能优化

*参考: [漫谈前端性能，突破React应用瓶颈](https://mp.weixin.qq.com/s/tCLvRad-WrnFKJiStU7BKw)*

1. 任务分片(React Fiber)：基于浏览器对 requestIdleCallback 和 requestAnimationFrame 这两个API 的支持，React 团队实现新的调度策略 — Fiber reconcile。
2. 结合 Web worker：
    1. React 结合 Web worker：  
        1. 标准的 React 应用由两部分构成: 
            - React core：负责绝大部分复杂的 Virtual DOM 计算；
            - React-Dom：负责与浏览器真实 DOM 交互来展示内容。  
        2. 我们尝试在 Web worker 中运行 React Virtual DOM 的相关计算。即将 React core 部分移入 Web worker 线程中。  
        3. worker线程postMessage通信的成本决定更新少部分节点的性能不好；
    2. Redux 结合 Web worker：  
        1. 将 Redux 中 reducer 复杂的纯计算过程放在 worker 线程里；
        2. 在实现层面，借助 Redux 库的 enchancer 设计，完成了抽象封装；
