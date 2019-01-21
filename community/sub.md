---
category: 社区
order: 30
title: 订阅号
---

这里提供 Ant Design 相关设计资源和设计工具的下载，更多设计资源正在整理和完善中。

- 新版本 Sketch Symbols 组件反馈地址：[🦜 反馈地址](https://www.yuque.com/kitchen/topics/51)

````jsx
import { Button } from 'antd';

const data = [
  {
    title: 'Ant Design Title 1',
  },
  {
    title: 'Ant Design Title 2',
  },
  {
    title: 'Ant Design Title 3',
  },
  {
    title: 'Ant Design Title 4',
  },
];
ReactDOM.render(
  <div>
    {data.map(res=>{
      return <Button type="primary">{res.title}</Button>
    })}
    <Button>Default</Button>
    <Button type="dashed">Dashed</Button>
    <Button type="danger">Danger</Button>
  </div>,
  mountNode
);
````

<div class="resource-cards">
  <a target="_blank" href="https://github.com/ant-design/ant-design/releases/download/resource/Ant.Design.Components.Beta.3.10.5.sketch" class="resource-card">
    <div class="resource-card-icon">
      <img width="65" src="https://gw.alipayobjects.com/zos/rmsportal/pKfDZnzocrbAOSzDQOQq.png">
    </div>
    <div class="resource-card-content">
      <span class="resource-card-title">
        新 Sketch Symbols 组件
        <span class="resource-card-hot-badge">BETA</span>
      </span>
      <span class="resource-card-description">桌面组件 Sketch 模板包</span>
    </div>
  </a>
</div>
