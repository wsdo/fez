---
sidebarDepth: 4
pageClass: custom-code-highlight
---

## 基于axios 的request 封装

```
import axios from 'axios'

axios.defaults.withCredentials = true
axios.defaults.timeout = 50000
axios.defaults.headers.common['Content-Type'] = 'application/json'
const errorStatus = [401, 500, 502, 504, 400]
// const baseURL = ``

axios.defaults.baseURL = 'http://api.shudong.wang/v1'
// 中间件 拦截请求-
axios.interceptors.response.use(
  response => {
    // if (errorStatus.indexOf(response.status) > -1) {
    //   router.push({
    //     path: '/',
    //   })
    // }
    // if ([403, -505].indexOf(response.data.code) > -1) {
    //   document.location.href = urlPassport
    // }
    return response
  },
  err => {
    if (!err.response) {
      // apiError('ApiError', err)
      return
    }
    const res = err.response
    const option = { status: res.status, url: res.config.url, params: res.config.params }
    // apiError('ApiError', option)
    // return Promise.reject(err)
  }
)

/**
 * get
 * @param url
 * @param data
 * @returns {Promise}
 */

const get = (url, params = {}) => {
  return new Promise((resolve, reject) => {
    axios
      .get(url, {
        params: params,
      })
      .then(response => {
        // if (response.data.code !== 1) {
        // console.error('api_error', response.data.msg)
        // reject(response)
        // }
        resolve(response)
      })
      .catch(error => {
        // reject(err)
      })
  })
}

/**
 * post
 * @param url
 * @param data
 * @returns {Promise}
 */

const post = (url, data = {}) => {
  return new Promise((resolve, reject) => {
    axios.post(url, data).then(
      response => {
        resolve(response)
      },
      err => {
        reject(err)
      }
    )
  })
}

export default {
  get,
  post,
}

```
