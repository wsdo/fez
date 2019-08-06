---
sidebarDepth: 4
pageClass: custom-code-highlight
---

## 父组件调用子组件方法：ref基础使用方式

## 父组件

```js
  constructor(props) {
    super(props)
    this.stark = null
  }
  changeVisible = (data, toggleCallVisible) => {
    this.stark.toggleVisible(data)
  }
// 调用子组件
<Stark
  ref={ref => {
    this.stark = ref
  }}
```


## 子组件
```js
  toggleVisible = (params) => {
    this.setState({
      visible: !this.state.visible,
    })
  }
```

## 如果子组件 需要调用store状态
```
export default connect(mapStateToProps, null, null, { withRef: true })(Stark)

```

