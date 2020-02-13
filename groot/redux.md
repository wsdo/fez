#redux是什么？

是一种解决方案
主要解决javascript中各组件传递数据日趋复杂的问题


######应用场景

适用于Vue React 原生js，是一种解决问题的思想逻辑

例子：在React中数据的流动是单向的，数据从上自下父组件流向子组件，由于这个特征，两个非父子关系的组件之间的通信就比较麻烦

![20200212142726](http://f.shudong.wang/starkwang/20200212142726.png)



######设计思想

只有一个状态树，整个应用的状态都存到一个地方 称为store

组件必须通过派发dispatch行为action去改变store里的状态

其他组件需要通过订阅store的方式来获知状态的改变


######Redux哲学

只有一颗state tree，且只存在于唯一一个store中

state是只读的，唯一改变state的方法就是触发action，action是一个用于编写逻辑的纯对象，使用纯函数来执行修改，为了描述action如何改变state tree 需要编写reducers

单一数据源的设计让React的组件通信更加方便，便于状态的统一管理

![20200212181405](http://f.shudong.wang/starkwang/20200212181405.png)



###一个redux的原生例子



