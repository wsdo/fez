![20200219175908](http://i.simbel.cn/note/20200219175908.png)
# React Hooks 入门-useEffect

## useEffect介绍

useEffect()用来引入具有副作用的操作，最常见的就是向服务器请求数据。

React 会等待浏览器完成画面渲染之后才会延迟调用 useEffect

以前，放在componentDidMount里面的代码，现在可以放在useEffect()。

使用示例：
```
import React, { useState, useEffect } from 'react'

export default function Demo01(){
  const [count, setCount] = useState(0)

  useEffect(() => {
    document.title = `clicked ${count} times`
  })

  return (<div>
    <button onClick={() => setCount(count + 1)}>点击</button>
  </div>)
}
```

## 如何让useEffect只执行一次
> 在function组件中，每当DOM完成一次渲染，都会有对应的副作用执行，useEffect用于提供自定义的执行内容，它的第一个参数（作为函数传入）就是自定义的执行内容。为了避免反复执行，传入第二个参数（由监听值组成的数组）作为比较(浅比较)变化的依赖，比较之后值都保持不变时，副作用逻辑就不再执行。

如果希望useEffect只执行一次，可以给带二个参数传入一个空数组，即没有传入比较变化的变量，则比较结果永远都保持不变，那么副作用逻辑就只能执行一次。

```
import React, { useState, useEffect } from 'react'

export default function Demo01(){
  const [count, setCount] = useState(0)

  useEffect(() => {
    console.log('执行useEffect') // 只会打印一次
  }, [])

  return (<div>
    <button onClick={() => setCount(count + 1)}>点击</button>
  </div>)
}
```

## useEffect 依赖

也可以让组件根据参数变化，执行useEffect，如下示例，Person组件根据传入的userid获取用户信息，userid不变的话不会重复执行

```
import React, { useState, useEffect } from "react";

function Person({ userid }) {
  const [person, setPerson] = useState();
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    console.log("exec useEffect");
    setLoading(true);
    fetch(`https://swapi.co/api/people/${userid}`)
      .then(res => res.json())
      .then(data => {
        setPerson(data);
        setLoading(false);
      });
  }, [userid]);

  return (
    <div>
      用户信息：
      <p>{loading ? "Loading..." : JSON.stringify(person)}</p>
    </div>
  );
}

export default function Demo03() {
  const [userid, setuUserid] = useState(1);
  return (
    <>
      <button onClick={() => setuUserid(1)}>用户1</button>
      <button onClick={() => setuUserid(2)}>用户2</button>
      <Person userid={userid} />
    </>
  );
}

```

> * 当依赖值为 object 时,他的值引用发生变化就会触发 effect 的更新，但是如果只是对象里某个值变化而引用不变化,effect 依旧不会触发
> * 如果初始值为 function, 而将其改为数字等,会触发 effect，function 也是一个对象,当我们添加一个值在上面时,他的 effect 也不会触发，引用为一个新函数时,他每次都会触发;

```
import React, { useState, useEffect } from 'react'

export default function Demo02(){
  let [data, setData] = useState({a: 123})
  useEffect(() => {
    console.log('执行useEffect')
  }, [data])
  const handleData = () => {
    data.a = Math.random() // 不会触发effect
    // setData({ a: 123 }) // 每次都会触发effect，引用地址发生了变化
  }

  return (<div>
    <button onClick={handleData}>点击</button>
  </div>)
}
```

## 如何清除useEffect

> 副作用回调函数中返回一个函数，用于副作用的清理工作。

### 官网案例：
```
useEffect(() => {
  ChatAPI.subscribeToFriendStatus(props.id, handleStatusChange);
  return () => {
    ChatAPI.unsubscribeFromFriendStatus(props.id, handleStatusChange);
  };
});
```
### 执行过程：
  * 每次副作用执行，都会返回一个新的clear函数
  * clear函数会在下一次副作用逻辑之前执行（DOM渲染完成之后）
  * 组件销毁也会执行一次

### 案例，一下代码的打印顺序是什么？

```
import React, { useState, useEffect } from 'react';

export default function AnimateDemo() {
  const [counter, setCounter] = useState(0);

  useEffect(() => {
    const timer = setTimeout(() => {
      setCounter(counter + 1);
    }, 300);
    console.log('effect:', timer);

    return () => {
      console.log('clear:', timer);
      clearTimeout(timer);
    }
  });

  console.log('before render');

  return (
    <div className="container">
      <div className="el">{counter}</div>
    </div>
  )
}
```

### 使用多个useEffect来执行不同的副作用逻辑

React Hooks 允许我们使用多个useEffect来执行不同的副作用逻辑。

React 将按照 effect 声明的顺序依次调用组件中的每一个 effect

```
import React, { useState, useEffect } from "react";

function Person({ userid }) {
  const [person, setPerson] = useState();
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    document.title = `当前是用户${userid}`
  })

  useEffect(() => {
    console.log("exec useEffect");
    setLoading(true);
    fetch(`https://swapi.co/api/people/${userid}`)
      .then(res => res.json())
      .then(data => {
        setPerson(data);
        setLoading(false);
      });
  }, [userid]);

  return (
    <div>
      用户信息：
      <p>{loading ? "Loading..." : JSON.stringify(person)}</p>
    </div>
  );
}

export default function Demo03() {
  const [userid, setuUserid] = useState(1);
  return (
    <>
      <button onClick={() => setuUserid(1)}>用户1</button>
      <button onClick={() => setuUserid(2)}>用户2</button>
      <Person userid={userid} />
    </>
  );
}

```

