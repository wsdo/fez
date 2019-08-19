---
title: '断言函数'
---
> 断言函数
```
export function assert (condition, msg) {
  if (!condition) throw new Error(`[vuex] ${msg}`)
}
```
