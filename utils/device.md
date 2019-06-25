---
order: 20
title: 判断设备
---


```js
export const isIos = () => /iPhone|iPad|iPod/i.test(navigator.userAgent)

export const isMobile = () => {
  let useragent = navigator.userAgent.toLowerCase()
  return useragent.indexOf('mobile') > -1 || useragent.indexOf('hjapp') > -1 || useragent.indexOf('android') > -1
}

export function isIPhoneX() {
  return /iPhone/gi.test(navigator.userAgent) && (screen.height === 812 && screen.width === 375)
}

export const isWeixin = () => /MicroMessenger/i.test(navigator.userAgent)

export const isQQ = () => /QQ/i.test(navigator.userAgent)


export const isWindows = () => navigator.userAgent.toLowerCase().indexOf('windows') >= 0

```
