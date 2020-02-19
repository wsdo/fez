---
title: lru-cache使用
categories: "lru-cache"
---

### lru-cache
一个高速缓存对象，用于删除最近最少使用的项目内容

### 安装
npm install lru-cache --save

地址： https://www.npmjs.com/package/lru-cache

### 使用场景
> nextjs框架使用服务端渲染数据，一旦用户量增大，频繁调取服务端接口会使服务器压力增大，造成不必要的麻烦，所以需要做页面缓存，减少不必要的数据调取。
> 网页登录信息缓存。对于需要获取登录信息的页面，我们需要给定一段时间内的信息缓存，避免频繁获取用户信息。
> 避免较短时间内页面频繁刷新造成资源频繁调取的情况。

### 基础用法
```
var LRU = require("lru-cache")
  , options = { max: 500  
              , length: function (n, key) { return n * 2 + key.length }
              , dispose: function (key, n) { n.close() }
              , maxAge: 1000 * 60 * 60 }
  , cache = new LRU(options)

cache.set("key", "value")
cache.get("key")

```

### options参数
> max： 缓存的最大大小。默认值为Infinity。手动设置时必须是为正的数字，非数字或负数会显示TypeError，设置为0时则为默认值Infinity
> maxAge: 设置缓存的最长时间。当set完一个key-value 后，超过 maxAge 设置的值时，LRU会自动把 key-value 删掉。
> length: 用于计算存储项目长度的函数。
> dispose: 从缓存中删除项目。
> stale: 默认情况下，如果设置了maxAge，则会将超时的项目从缓存中删除，但如果设置了stale:true, 它将在删除之前返回旧的值。
> noDisposeOnSet: 默认情况下，如果您设置了一个dispose()方法，则只要set()操作覆盖现有键，就会调用该方法。如果设置此选项，dispose()则仅当密钥从缓存中掉出时才调用，而不是在其被覆盖时才调用。
> updateAgeOnGet: 当将带有过期时间的条目与一起使用，将此选项设置为true会使每一项从缓存中检索到的有效时间都更新为当前时间，从而不会过期。（当然，根据使用的新近度，它仍然可能会从缓存中掉出来。）

### API
> set(key, value, maxAge)
  设置缓存，maxAge可选，设置则覆盖全局提供的maxAge
> get(key) => value
  获取key下的缓存内容，如果照不到key值，将返回undefined。
> peek(key)
  返回该键下的键值，如果未找到则返回undefined。
> del(key)
  从缓存中删除该key值
> reset()
  完全清除缓存，丢弃所有值
> has(key)
  检查该key值是否存在于缓存中。
> forEach(function(value,key,cache), [thisp])
  按照最新的顺序遍历缓存中的所有项。（首先返回最近使用的项）
> rforEach(function(value,key,cache), [thisp])
  与forEach相反的顺序遍历所有项。（首先返回最少使用的项）
> keys()
  返回缓存中的键的数组。
> values()
  返回缓存中的键值的数组。
> length
  返回缓存中对象的总长度。
> itemCount
  返回当前缓存中的对象总数。
> dump()
  返回准备好进行序列化和使用'destinationCache.load（arr）`的缓存条目数组。
> load(cacheEntriesArray)
  将通过获取的另一个缓存条目数组加载sourceCache.dump()到缓存中。在加载新条目之前，将重置目标缓存。
> prune()
  手动遍历整个缓存，主动清除旧的条目。

eg:
```
  let list = []
  console.log(ssrCache.has("list"))  // true or false
  console.log(ssrCache.peek("list")) // undefined or []
  if (ssrCache.has("list")) {  // 如果查询到缓存中有list值，则返回true
    list = ssrCache.get("list")   // 并使用缓存中的数据
  }else{   // 未查询到缓存中存在该值
    list = await store.dispatch.demo.test()  // 则运行调取数据
    if(list && list.length){
      ssrCache.set('list', list)  // 存储数据在缓存中list键下
    }
  }
  return { list };
```