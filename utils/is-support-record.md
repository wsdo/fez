---
order: 20
title: 判断是否支持录音
---

```js
const checkAppleWebkit = () => {
  let isSupport = true
  const isSafari = navigator.userAgent.indexOf('AppleWebKit') > -1
  if (isSafari && isIos()) {
    const reAppleWebKit = new RegExp('AppleWebKit/(\\d+(?:\\.\\d*)?)')
    reAppleWebKit.test(navigator.userAgent)
    if (parseFloat(RegExp.$1) < 605) {
      isSupport = false
    }
  }
  return isSupport
}

// 检测是否支持录音
export const isRecord = () => new Promise((resolve, reject) => {
  let res = true
  if (!isHJApp() && !isWeixin()) {
    res = checkAudioContext() && checkGetUserMedia() && checkCatchMedia()
    // && checkAppleWebkit()
  }
  resolve(res)
})
```
