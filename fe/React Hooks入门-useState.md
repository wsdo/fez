# React Hooks 入门-useState

## useState介绍

useState()用于为函数组件引入状态（state）

useState用法比较简单，useState 接收一个参数，作为state的初始值，返回一个数组，数组第一个值是当前state，第二个值是更新state的方法。

```
import React, { useState } from 'react';

function Example() {
  // 声明一个叫 “count” 的 state 变量和改变 count 的函数 setCount
  const [count, setCount] = useState(0);
  return (
    <>
      <p>{count}</p>
      {/* 更新状态count时，直接调用setCount */}
      <button onClick={() => setCount(count + 1)}>加1</button>
    </>
  )
}
```
state 只在组件首次渲染的时候被创建。在下一次重新渲染时，useState 返回给我们当前的 state。

## useState 实践

效果图：
![20200213155807](http://i.simbel.cn/note/20200213155807.png)

示例代码：
```
import React, { useState } from "react";
import { Slider, Row, Col } from "antd";

const BoxGenerator = () => {
  const [height, setHeight] = useState(100);
  const [width, setWidth] = useState(100);
  const [color, setColor] = useState({ r: 0, g: 0, b: 0 });
  const [borderRadius, setBorderRadius] = useState(100);

  const style = {
    height,
    width,
    backgroundColor: `rgb(${color.r}, ${color.g}, ${color.b})`,
    borderRadius
  };

  return (
    <div style={{ border: '1px #ccc solid', padding: 10, width: 600, margin: '10px auto' }}>
      <Row>
        <Col span={4}>Width：</Col>
        <Col span={20}>
          <Slider min={10} max={300} value={width} onChange={width => setWidth(width)} />
        </Col>
      </Row>
      <Row>
        <Col span={4}>Height:</Col>
        <Col span={20}>
          <Slider min={10} max={300} value={height} onChange={height => setHeight(height)} />
        </Col>
      </Row>
      <Row>
        <Col span={4}>Color:</Col>
        <Col span={20}>
          <h3>R:</h3>
          <Slider
            min={0}
            max={255}
            value={color.r}
            onChange={r => setColor({ ...color, r })}
          />
          <h3>G:</h3>
          <Slider
            min={0}
            max={255}
            value={color.g}
            onChange={g => setColor({ ...color, g })}
          />
          <h3>B:</h3>
          <Slider
            min={0}
            max={255}
            value={color.b}
            onChange={b => setColor({ ...color, b })}
          />
        </Col>
      </Row>
      <Row>
        <Col span={4}>Border Radius:</Col>
        <Col span={20}>
          <Slider min={10} max={300} value={borderRadius} onChange={borderRadius => setBorderRadius(borderRadius)} />
        </Col>
      </Row>
      <Row>
        <Col span={20} offset={4}>
          <div style={style}></div>
        </Col>
      </Row>
    </div>
  );
};

export default BoxGenerator;

```

