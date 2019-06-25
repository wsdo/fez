---
order: 0
title: 常用
---

```js
// 判断是否包含汉子
export const isChinese = (str) => {
  if (escape(str).indexOf('%u') < 0) return false
  return true
}


// 把表情去掉
export const emoj2str = (str) => {
  return unescape(escape(str).replace(/\%uD.{3}/g, ''))
}

export const safeText = (str) => {
  let res = emoj2str(str)
  if (isChinese(res)) {
    res = res.length > 4 ? `${res.slice(0, 4)}...` : res
  } else {
    res = res.length > 7 ? `${res.slice(0, 7)}...` : res
  }
  return res
}

```
