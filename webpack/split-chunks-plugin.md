---
title: SplitChunksPlugin 参数详解
categories: webpack
---

> 最初，Chunk(以及在其中导入的模块)是通过内部 webpack 图中的父子关系连接的。 使用 CommonsChunkPlugin 是为了避免它们之间的重复依赖关系，但无法进一步优化。

> 自从 webpack v4以来，CommonsChunkPlugin 被删除，以支持 optimization.splitchunk。

## 默认值 Defaults

开箱即用 SplitChunksPlugin 应该对大多数用户都适用。

默认情况下，它只影响按需块，因为更改初始块会影响 HTML 文件运行项目时应该包含的脚本标记。

Webpack 将根据以下条件自动分割块:

* 新块可以共享，或者模块来自node_modules folder 文件夹
* 新块大于30kb (在 min + gz 之前)

* 当根据需要加载块时，并行请求的最大数量将低于或等于6
* 在初始页面加载时，并行请求的最大数量将小于或等于4

当试图满足最后两个条件时，更大的块是首选的。

## 配置 Configuration

Webpack 为希望更多地控制该功能的开发人员提供了一组选项。

选择默认配置是为了适应 web 性能的最佳实践，但是您的项目的最佳策略可能不同。 如果您正在更改配置，那么您应该测量更改的影响，以确保有真正的好处。

## optimization.splitChunks

This configuration object represents the default behavior of the `SplitChunksPlugin`.

这个配置对象表示 SplitChunksPlugin 的默认行为。

__webpack.config.js__

```webpack.config.js

module.exports = {
  //...
  optimization: {
    splitChunks: {
      chunks: 'async',
      minSize: 30000,
      minRemainingSize: 0,
      maxSize: 0,
      minChunks: 1,
      maxAsyncRequests: 6,
      maxInitialRequests: 4,
      automaticNameDelimiter: '~',
      automaticNameMaxLength: 30,
      cacheGroups: {
        defaultVendors: {
          test: /[\\/]node_modules[\\/]/,
          priority: -10
        },
        default: {
          minChunks: 2,
          priority: -20,
          reuseExistingChunk: true
        }
      }
    }
  }
};
```
![20200217141530](http://s.shudong.wang/shudong/20200217141530.png)

W> When files paths are processed by webpack, they always contain / on Unix systems and \ on Windows. That's why using [\\/] in {cacheGroup}.test fields is necessary to represent a path separator. / or \ in {cacheGroup}.test will cause issues when used cross-platform.

当文件路径被 webpack 处理时，它们总是包含 / 在 Unix 系统和 Windows 上。 这就是为什么在{ cacheGroup }中使用[ / ]。 必须使用测试字段来表示路径分隔符。 / 或 in { cacheGroup }。 测试将导致问题时，使用跨平台。

### `splitChunks.automaticNameDelimiter`

`string`

默认情况下，webpack 将使用块的起源和名称(例如 vendors ~ main.js)生成名称。 

* 此选项允许您指定用于生成的名称的分隔符。

### `splitChunks.automaticNameMaxLength`

`number = 109`

允许为 SplitChunksPlugin 生成的块名设置最大字符数。

### `splitChunks.chunks`

`function (chunk) string`

参数将选择哪些方式进行优化。 
* 当这个选项是字符串时，有效值为 `all`, `async`, 和 `initial`.
* 当这个选项为 `all`时，因为这意味着即使在异步块和非异步块之间都可以生效。

webpack.config.js

__webpack.config.js__

```js
module.exports = {
  //...
  optimization: {
    splitChunks: {
      // include all types of chunks
      chunks: 'all'
    }
  }
};
```

或者，您可以提供一个函数来进行更多的控制。返回值将指示是否包含每个块。

```js
module.exports = {
  //...
  optimization: {
    splitChunks: {
      chunks (chunk) {
        // exclude `my-excluded-chunk`
        return chunk.name !== 'my-excluded-chunk';
      }
    }
  }
};
```

你可以把这个配置和 HtmlWebpackPlugin 结合起来，它会为你注入所有生成的供应商块。

### splitChunks.maxAsyncRequests

number

> Maximum number of parallel requests when on-demand loading.

按需加载时并行请求的最大数量。

### `splitChunks.maxInitialRequests`

`number`

Maximum number of parallel requests at an entry point.

入口点上并行请求的最大数量。

### splitChunks.minChunks

`number`

分割前必须共享模块的最小块数。

### splitChunks.minSize

`number`

要生成的块的最小大小(以字节为单位)。

### splitChunks.minRemainingSize
#### splitChunks.cacheGroups.{cacheGroup}.minRemainingSize

`number`

在 webpack 5中引入了 minremainingsize 选项，以确保分割后剩余块的最小大小超过一个限制，从而避免零大小的模块。 在“开发”模式下默认为0。 对于其他情况，splitChunks.minRemainingSize 默认值为 splitChunks.minSize，因此除了极少数需要深度控制的情况外，不需要手动指定它。

只有当剩下一个块时，minremainingsize 才会生效。

### splitChunks.maxSize

`number`

使用 maxSize (全局优化.splitchunks.maxSize / cache 组优化.splitchunks.cachegroups [ x ]。 Maxsize)告诉 webpack 尝试将比 maxSize 大的块拆分为更小的部分。 零件的尺寸至少小于最大尺寸(仅次于最大尺寸)。 该算法是确定性的，对模块的更改只会产生局部影响。 因此，当使用长期缓存时，它是可用的，并且不需要记录。 Maxsize 只是一个提示，当模块大于 maxSize 时，可能会违反 maxSize，或者分割会违反 minSize。

当块已经有一个名称时，每个部分将从该名称派生出一个新名称。 根据 optimization.splitChunks.hidePathInfo 的值，它将添加从第一个模块名派生的键或其散列。

maxSize option is intended to be used with HTTP/2 and long term caching. It increases the request count for better caching. It could also be used to decrease the file size for faster rebuilding.

Maxsize 选项用于 http / 2和长期缓存。 它增加了更好的缓存请求计数。 它还可以用来减小文件大小，以便更快地重新生成。

maxSize takes higher priority than maxInitialRequest/maxAsyncRequests. Actual priority is maxInitialRequest/maxAsyncRequests < maxSize < minSize.

Maxsize 的优先级高于 maxinitialrequest / maxasyncrequests。

Setting the value for maxSize sets the value for both maxAsyncSize and maxInitialSize.

设置 maxSize 的值将同时设置 maxAsyncSize 和 maxInitialSize 的值。

### splitChunks.maxAsyncSize

`number`

Like maxSize, maxAsyncSize can be applied globally (splitChunks.maxAsyncSize), to cacheGroups (splitChunks.cacheGroups.{cacheGroup}.maxAsyncSize), or to the fallback cache group (splitChunks.fallbackCacheGroup.maxAsyncSize).

与 maxSize 一样，maxAsyncSize 可以全局应用(splitchunks.maxAsyncSize) ，也可以应用于 cacheGroups (splitchunks.cacheGroups. { cacheGroup } . maxAsyncSize)或 fallback 缓存组(splitchunks.fallbackcachegroup.asyncsize)。

The difference between maxAsyncSize and maxSize is that maxAsyncSize will only affect on-demand loading chunks.

Maxasyncsize 和 maxSize 的区别在于 maxAsyncSize 只会影响按需加载的块。

### splitChunks.maxInitialSize

`number`

Like maxSize, maxInitialSize can be applied globally (splitChunks.maxInitialSize), to cacheGroups (splitChunks.cacheGroups.{cacheGroup}.maxInitialSize), or to the fallback cache group (splitChunks.fallbackCacheGroup.maxInitialSize).

像 maxSize 一样，maxInitialSize 可以全局应用(splitchunks.maxInitialSize) ，可以应用于 cacheGroups (splitchunks.cacheGroups. { cacheGroup } . maxInitialSize) ，也可以应用于 fallback 缓存组(splitchunks.fallbackcachegroup.maxInitialSize)。

The difference between maxInitialSize and maxSize is that maxInitialSize will only affect initial load chunks.

Maxinitialsize 和 maxSize 的区别在于 maxInitialSize 只会影响初始加载块。

### splitChunks.name


`boolean = true function (module, chunks, cacheGroupKey) => string` `string`

Also available for each cacheGroup: splitChunks.cacheGroups.{cacheGroup}.name.

也可用于每个 cacheGroup: splitChunks.cacheGroups. { cacheGroup } . name。

提供 true 将根据块和缓存组密钥自动生成一个名称。

提供字符串或函数允许您使用自定义名称。 指定总是返回相同字符串的字符串或函数将把所有公共模块和供应商合并到一个块中。 这可能会导致更大的初始下载量和降低页面加载速度。

如果您选择指定一个函数，您可能会发现 chunk.name 和 chunk.hash 属性(其中 chunk 是块数组的一个元素)在为块选择名称时特别有用。

如果 splitchunks.name 文件与入口点名称匹配，入口点将被移除。

建议在生产构建中将 splitchunks.name / 代码设置为 false，这样它就不会不必要地更改名称。

__main.js__

```js


import _ from 'lodash';

console.log(_.join(['Hello', 'webpack'], ' '));
```

__webpack.config.js__
```js
module.exports = {
  //...
  optimization: {
    splitChunks: {
      cacheGroups: {
        commons: {
          test: /[\\/]node_modules[\\/]/,
          // cacheGroupKey here is `commons` as the key of the cacheGroup
          name(module, chunks, cacheGroupKey) {
            const moduleFileName = module.identifier().split('/').reduceRight(item => item);
            const allChunksNames = chunks.map((item) => item.name).join('~');
            return `${cacheGroupKey}-${allChunksNames}-${moduleFileName}`;
          },
          chunks: 'all'
        }
      }
    }
  }
};
```

使用以下 splitChunks 配置运行 webpack 也会输出通用组的一个块，它的下一个名称是: commons-main-lodash。 Js.e7519d2bb8777058fa27.js (作为实际输出示例给出的哈希)。

当为不同的分割块分配相同的名称时，所有供应商模块都被放置到一个共享块中，尽管这是不被推荐的，因为它会导致更多的代码下载。

### splitChunks.automaticNamePrefix
`string = ''`

为创建的块设置名称前缀。

```js
module.exports = {
  //...
  optimization: {
    splitChunks: {
      automaticNamePrefix: 'general-prefix',
      cacheGroups: {
        react: {
          // ...
          automaticNamePrefix: 'react-chunks-prefix'
        }
      }
    }
  }
};
```


### `splitChunks.cacheGroups`
Cache groups can inherit and/or override any options from splitChunks.*; but test, priority and reuseExistingChunk can only be configured on cache group level. To disable any of the default cache groups, set them to false.

缓存组可以继承 和/或 重写 splitChunks 中的任何选项。 splitChunks.* ; 但是 test、 priority 和 reuseExistingChunk 只能在缓存组级别上配置。 若要禁用任何默认缓存组，请将它们设置为 false。

__webpack.config.js__

2. webpack.config.js
```
module.exports = {
  //...
  optimization: {
    splitChunks: {
      cacheGroups: {
        default: false
      }
    }
  }
};
```
### `splitChunks.cacheGroups.{cacheGroup}.priority`

`number`

一个模块可以属于多个缓存组。 优化将偏好具有更高优先级的缓存组。 默认组的优先级为负，以允许自定义组获得更高的优先级(自定义组的默认值为0)。

#### splitChunks.cacheGroups.{cacheGroup}.reuseExistingChunk
`boolean`

If the current chunk contains modules already split out from the main bundle, it will be reused instead of a new one being generated. This can impact the resulting file name of the chunk.

如果当前块包含已经从主包中分离出来的模块，那么将重用它，而不是生成新的模块。 这可能会影响块的结果文件名。

__webpack.config.js__

2. webpack.config.js
```
module.exports = {
  //...
  optimization: {
    splitChunks: {
      cacheGroups: {
        defaultVendors: {
          reuseExistingChunk: true
        }
      }
    }
  }
};
```

#### splitChunks.cacheGroups.{cacheGroup}.type

```function RegExp string```

Allows to assign modules to a cache group by module type.
允许按模块类型将模块分配给缓存组。

___webpack.config.js__

2. webpack.config.js
```
module.exports = {
  //...
  optimization: {
    splitChunks: {
      cacheGroups: {
        json: {
          type: 'json'
        }
      }
    }
  }
};
```

#### splitChunks.cacheGroups.test
#### splitChunks.cacheGroups.{cacheGroup}.test
function (module, chunk) => boolean RegExp string

Controls which modules are selected by this cache group. Omitting it selects all modules. It can match the absolute module resource path or chunk names. When a chunk name is matched, all modules in the chunk are selected.

控制此缓存组选择哪些模块。 省略它选择所有模块。 它可以匹配绝对模块资源路径或块名称。 当一个块名称匹配时，块中的所有模块都被选中。

Providing a function to{cacheGroup}.test:

为{ cacheGroup } . test 提供一个函数:

__webpack.config.js__

2. webpack.config.js
```
module.exports = {
  //...
  optimization: {
    splitChunks: {
      cacheGroups: {
        svgGroup: {
          test(module, chunks) {
            // `module.resource` contains the absolute path of the file on disk.
            // Note the usage of `path.sep` instead of / or \, for cross-platform compatibility.
            const path = require('path');
            return module.resource &&
                 module.resource.endsWith('.svg') &&
                 module.resource.includes(`${path.sep}cacheable_svgs${path.sep}`);
          }
        },
        byModuleTypeGroup: {
          test(module, chunks) {
            return module.type === 'javascript/auto';
          }
        }
      }
    }
  }
};
```
In order to see what information is available in module and chunks objects, you can put debugger; statement in the callback. Then run your webpack build in debug mode to inspect the parameters in Chromium DevTools.

为了查看模块和块对象中有哪些信息可用，可以在回调中放置 debugger; 语句。 然后在调试模式下运行 webpack 构建来检查 Chromium 开发工具中的参数。

Providing a RegExp to {cacheGroup}.test:

向{ cacheGroup } . test 提供 RegExp:

__webpack.config.js__

2. webpack.config.js
```
module.exports = {
  //...
  optimization: {
    splitChunks: {
      cacheGroups: {
        defaultVendors: {
          // Note the usage of `[\\/]` as a path separator for cross-platform compatibility.
          test: /[\\/]node_modules[\\/]|vendor[\\/]analytics_provider|vendor[\\/]other_lib/
        }
      }
    }
  }
};

```
#### splitChunks.cacheGroups.{cacheGroup}.filename
string function (chunkData): string

当且仅当文件是初始块时，允许重写文件名。 在 output.filename 中提供的所有占位符在这里也可以使用。


这个选项也可以在 splitChunks.filename 中全局设置，但是不推荐这样做，如果 splitchunks.chunk 没有设置为‘ initial’ ，可能会导致错误。 避免全局设置。

__webpack.config.js__

2. webpack.config.js

```
module.exports = {
  //...
  optimization: {
    splitChunks: {
      cacheGroups: {
        defaultVendors: {
          filename: '[name].bundle.js'
        }
      }
    }
  }
};

```
And as a function:

作为一个函数:

webpack.config.js

2. webpack.config.js
```
module.exports = {
  //...
  optimization: {
    splitChunks: {
      cacheGroups: {
        defaultVendors: {
          filename: (chunkData) => {
            // Use chunkData object for generating filename string based on your requirements
            return `${chunkData.chunk.name}-bundle.js`;
          }
        }
      }
    }
  }
};
```
It is possible to create a folder structure by providing path prefixing the filename: 'js/vendor/bundle.js'.

可以通过提供文件名前缀“ js / vendor / bundle. js”的路径来创建文件夹结构。

webpack.config.js

2. webpack.config.js
```
module.exports = {
  //...
  optimization: {
    splitChunks: {
      cacheGroups: {
        defaultVendors: {
          filename: 'js/[name]/bundle.js'
        }
      }
    }
  }
};
```
#### splitChunks.cacheGroups.{cacheGroup}.enforce
boolean = false


告诉 webpack 忽略 splitChunks.minSize，splitchunks.minchunk，splitChunks.maxAsyncRequests 和 splitChunks.maxInitialRequests 选项，并始终为这个缓存组创建块。

__webpack.config.js__

2. webpack.config.js

```
module.exports = {
  //...
  optimization: {
    splitChunks: {
      cacheGroups: {
        defaultVendors: {
          enforce: true
        }
      }
    }
  }
};
```
#### splitChunks.cacheGroups.{cacheGroup}.idHint
string

Sets the hint for chunk id. It will be added to chunk's filename.

设置块 id 的提示。它将被添加到块的文件名中。

webpack.config.js

2. webpack.config.js
```
module.exports = {
  //...
  optimization: {
    splitChunks: {
      cacheGroups: {
        defaultVendors: {
          idHint: 'vendors'
        }
      }
    }
  }
};
```
例子
默认值: 示例1
// index.js

import('./a'); // dynamic import
// a.js
import 'react';

//...
Result: A separate chunk would be created containing react. At the import call this chunk is loaded in parallel to the original chunk containing ./a.

结果: 一个包含反应的独立块被创建出来。 在导入调用时，该块与包含该块的原始块并行加载。 / a.


为什么:

条件1: 块包含来自node_modules

条件第2项:r eact is bigger than 30kb 大于30kb

条件3: 导入调用中的并行请求数为2

条件4: 在初始页面加载时不影响请求

这背后的原因是什么？ react可能不会像应用程序代码那样经常变化。 通过将其移动到一个单独的块中，这个块可以与你的应用程序代码分开缓存(假设你正在使用 chunkhash、 records、 Cache-Control 或其他长期缓存方法)。

默认值: 示例2
// entry.js

// dynamic imports
```
import('./a');
import('./b');
```
// a.js
import './helpers'; // helpers is 40kb in size

//...
// b.js
import './helpers';
import './more-helpers'; // more-helpers is also 40kb in size

//...
Result: A separate chunk would be created containing ./helpers and all dependencies of it. At the import calls this chunk is loaded in parallel to the original chunks.

结果: 将创建一个包含。 / helpers 及其所有依赖关系。 在导入调用时，这个块与原始块并行加载。

Why:

为什么:

Condition 1: The chunk is shared between both import calls 条件1: 这个块在两个导入调用之间共享
Condition 2: 条件第2项:helpers is bigger than 30kb 大于30kb
Condition 3: Number of parallel requests at the import calls is 2 条件3: 导入调用中的并行请求数为2
Condition 4: Doesn't affect request at initial page load 条件4: 在初始页面加载时不影响请求
Putting the content of helpers into each chunk will result into its code being downloaded twice. By using a separate chunk this will only happen once. We pay the cost of an additional request, which could be considered a tradeoff. That's why there is a minimum size of 30kb.

将 helpers 的内容放入每个块将导致其代码被下载两次。 通过使用单独的块，这种情况只会发生一次。 我们支付额外请求的费用，这可以被认为是一种折衷。 这就是为什么最小的大小是30kb。

Split Chunks: Example 1
分块: 例1
Create a commons chunk, which includes all code shared between entry points.

创建一个公共块，其中包括入口点之间共享的所有代码。

__webpack.config.js__

2. webpack.config.js
```
module.exports = {
  //...
  optimization: {
    splitChunks: {
      cacheGroups: {
        commons: {
          name: 'commons',
          chunks: 'initial',
          minChunks: 2
        }
      }
    }
  }
};
```
这种配置可以放大您的初始捆绑包，建议在不需要立即使用模块时使用动态导入。

分块: 例2
创建一个供应商块，其中包括整个应用程序中节点模块的所有代码。

__webpack.config.js__

2. webpack.config.js
```
module.exports = {
  //...
  optimization: {
    splitChunks: {
      cacheGroups: {
        commons: {
          test: /[\\/]node_modules[\\/]/,
          name: 'vendors',
          chunks: 'all'
        }
      }
    }
  }
};
```

这可能导致包含所有外部包的大块。 建议只包含您的核心框架和实用程序，并动态加载其余的依赖项。

分块: 例3
创建一个自定义供应商块，其中包含与 RegExp 匹配的某些节点模块包。

__webpack.config.js__

2. webpack.config.js
```
module.exports = {
  //...
  optimization: {
    splitChunks: {
      cacheGroups: {
        vendor: {
          test: /[\\/]node_modules[\\/](react|react-dom)[\\/]/,
          name: 'vendor',
          chunks: 'all',
        }
      }
    }
  }
};
```

这将导致分裂反应和反应多姆成为一个单独的块。 如果您不确定一个块中包含了哪些包，可以参考包分析部分获得详细信息。

