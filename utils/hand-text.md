---
title: '分别处理汉字和字母的长度，外加过虑表情'
---

> 分别处理汉字和字母的长度，外加过虑表情
```
export const isChinese = str => {
  if (escape(str).indexOf('%u') < 0) return false
  return true
}

export const emoj2str = str => {
  return unescape(escape(str).replace(/\%uD.{3}/g, ''))
}

export const handleText = str => {
  let res = emoj2str(str)
  if (isChinese(res)) {
    res = res.length > 4 ? res.slice(0, 4) + '...' : res
  } else {
    res = res.length > 7 ? res.slice(0, 7) + '...' : res
  }
  return res
}
```
