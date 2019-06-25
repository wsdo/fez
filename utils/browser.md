---
order: 0
title: 判断是哪个浏览器
---

```js
export const isFirefox = () => {
  let useragent = navigator.userAgent.toLowerCase()
  return useragent.indexOf('firefox') > -1
}
export const isChrome = () => {
  let useragent = navigator.userAgent.toLowerCase()
  return useragent.indexOf('chrome') > -1
}
```
