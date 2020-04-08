
# React Hooks 入门-简介

## 1. 什么是 Hook
> Hook 是能让你在函数组件中“钩入” React 特性的函数。

简单理解就是，**有状态的函数式组件**

## 2. Why Hook？

### 2.1 class组件的问题

  Redux 的作者 Dan Abramov 总结了组件类的几个缺点:
   * 大型组件很难拆分和重构，也很难测试。
   * 业务逻辑分散在组件的各个方法之中，导致重复逻辑或关联逻辑。
   * 组件类引入了复杂的编程模式，比如 render props 和高阶组件。
  
  我的直观感受就是，生命周期复杂难记，不好理解，开发时还要注意this指向问题

### 2.2 Hooks优势

1. 简洁。 
   比如实现一个点击加1示例：
   ```
   import React, { useState } from 'react'

   export default function HookDemo(){
    const [counter, setCounter] = useState(0)
    return (
      <>
        <p>{counter}</p>
        <button onClick={() => setCounter(counter + 1)}> 加1 </button>
      </>
    )
   }
   ```

2. 不用记复杂的生命周期函数，没有this指向问题困扰
3. 100%向后兼容的，Hook和现有代码可以同时工作
   