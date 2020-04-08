---
order: 20
title: CSS及静态资源引入
---

## CSS

  ### 支持内嵌的CSS

  我们绑定 styled-jsx 来生成独立作用域的 CSS. 目标是支持类似于web组件的 "shadow CSS", 但是 不支持独立模块作用域的 JS.

  举个栗子🌰:

  ```
  export default () =>
  <div>
    Hello world
    <p>scoped!</p>
    # 作用域为<style jsx>以前的标签
    <style jsx>{`
      p {
        color: blue;
      }
      div {
        background: red;
      }
      @media (max-width: 600px) {
        div {
          background: blue;
        }
      }
    `}</style>
    <h2>green</h2>
    <style jsx>{`
      h2 {
        color: green;
      }    
    `}
    </style>
  </div>
  ```

  #### 内嵌样式

  使用CSS 内嵌 JS 写法

  举个栗子🌰: 

  ```
    export default () => <p style={{ color: 'red' }}>hi there</p>
  ```

  Examples
    - [Styled components](https://github.com/zeit/next.js/tree/7.0.0-canary.8/examples/with-styled-components)
    - [Styletron](https://github.com/zeit/next.js/tree/7.0.0-canary.8/examples/with-styletron)
    - [Glamor](https://github.com/zeit/next.js/tree/7.0.0-canary.8/examples/with-glamor)
    - [Glamorous](https://github.com/zeit/next.js/tree/7.0.0-canary.8/examples/with-glamorous)
    - [Cxs](https://github.com/zeit/next.js/tree/7.0.0-canary.8/examples/with-cxs)
    - [Aphrodite](https://github.com/zeit/next.js/tree/7.0.0-canary.8/examples/with-aphrodite)
    - [Fela](https://github.com/zeit/next.js/tree/7.0.0-canary.8/examples/with-fela)

    服务端渲染的时样式更改,可以通过包裹自定义 Document，来添加样式
    eg: 
    [Styled components custom document](https://github.com/zeit/next.js/tree/7.0.0-canary.8/examples/with-styled-components)



  ### 使用 CSS / Sass / Less / Stylus files

    支持用.css, .scss, .less or .styl，需要配置默认文件 next.config.js

    举个栗子🌰: 

    ```
      # 安装
      npm install --save @zeit/next-css
      # or
      yarn add @zeit/next-css
    ```

    在项目的根目录（在pages /和package.json旁边）中创建一个next.config.js文件

    ```
    # next.config.js
    const withCSS = require('@zeit/next-css')
    module.exports = withCSS({
      # 设置css模块
      cssModules: true
    })
    ```

    引入页面,创建一个css文件 index.css
    ```
    .example {
      font-size: 50px;
    }
    ```
    在pages/index.js中引入css文件
    ```
    import css from "../index.css"

    export default () => <div className={css.example}>Hello World!</div>
    ```

    您还可以通过传递一个名为cssLoaderOptions的对象，将选项列表传递给css-loader。例如，要启用局部作用域的CSS模块，可以这样写:
    ```
      # next.config.js
      const withCSS = require('@zeit/next-css')
      module.exports = withCSS({
        cssModules: true,
        cssLoaderOptions: {
          importLoaders: 1,
          localIdentName: "[local]___[hash:base64:5]",
        }
      })
    ```

## 静态资源文件服务（如图像）

  在根目录下新建文件夹叫static。代码可以通过/static/来引入相关的静态资源。
  or
  在根目录下新建文件夹叫public。代码可以直接引入相关的静态资源。

  引入方法：

  ```
    # /static/my-image.png
    export default () => <img src="/static/my-image.png" alt="my image" />
    # /public/my-image.png
    export default () => <img src="/my-image.png" alt="my image" />
  ```

