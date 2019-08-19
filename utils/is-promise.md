---
title: '判断是否是 promise'
---
> 判断是否是 promise

```
export function isPromise (val) {
  return val && typeof val.then === 'function'
}
```
