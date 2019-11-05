---
order: 20
title: 生成head、获取数据及生命周期
---

## head
  通过一个内置组件来将<head>加载到页面中

  举个栗子🌰：

  ```
    import Head from 'next/head'

    function Index() {
      return (
        <div>
          <Head>
            <title>hello, nextJs!</title>
            <meta name="viewport" content="initial-scale=1.0, width=device-width" />
          </Head>
        </div>
      )
    }

    export default Index
  ```

  ![head](http://f.shudong.wang/shudong/4Y5BfRFL2P20191105170917907.png)

  注意：<head>会在组件卸载时被清除，所以需要确保在每个页面中定义了所需要的内容。

  为了避免出现重复的<head>标签，保证<head>只渲染一次，我们可以定义一个key属性

  举个栗子🌰：

  当有两个<head>标签时，只有最后一个<head>被渲染
  ```
  import Head from 'next/head'
  export default () => (
    <div>
      <Head>
        <title>My page title</title>
        <meta name="viewport" content="initial-scale=1.0, width=device-width" key="viewport" />
      </Head>
      <Head>
        <meta name="viewport" content="initial-scale=1.2, width=device-width" key="viewport" />
      </Head>
    </div>
  )
  ```

## 获取数据以及组件生命周期
  如果我们需要一个带有状态、生命周期或者有初始数据的组件时

  ```
  import React from 'react'

  export default class extends React.Component {
    # 异步获取 JS 普通对象，并绑定在props上
    static async getInitialProps({ req }) {
      const userAgent = req ? req.headers['user-agent'] : navigator.userAgent
      return { userAgent }
    }

    render() {
      return (
        <div>
          Hello World {this.props.userAgent}
        </div>
      )
    }
  }
  ```

