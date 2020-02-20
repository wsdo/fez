
## 概念
`webpack` compiler 能够识别遵循 ES2015 模块语法、CommonJS 或 AMD 规范编写的模块。然而，一些 third party(第三方库) 可能会引用一些全局依赖（例如 `jQuery` 中的 `$`）。因此这些 library 也可能会创建一些需要导出的全局变量。这些 "broken modules(不符合规范的模块)" 就是 _shim(预置依赖)_ 发挥作用的地方。

> __我们不推荐使用全局依赖！__webpack 背后的整个理念是使前端开发更加模块化。也就是说，需要编写具有良好的封闭性(well contained)、不依赖于隐含依赖（例如，全局变量）的彼此隔离的模块。请只在必要的时候才使用这些特性。

_shim_ 另外一个极其有用的使用场景就是：当你希望 [polyfill](https://en.wikipedia.org/wiki/Polyfill_%28programming%29) 扩展浏览器能力，来支持到更多用户时。在这种情况下，你可能只是想要将这些 polyfills 提供给需要修补(patch)的浏览器（也就是实现按需加载）。

下面的文章将向我们展示这两种用例。

> 为了方便，本指南继续沿用 [起步](/guides/getting-started) 中的代码示例。在继续之前，请确保你已经熟悉这些配置。


## shim 预置全局变量

让我们开始第一个 shim 全局变量的用例。在此之前，先看下我们的项目：

__project__

``` diff
webpack-demo
|- package.json
|- webpack.config.js
|- /dist
|- /src
  |- index.js
|- /node_modules
```

还记得我们之前用过的 `lodash` 吗？出于演示目的，例如把这个应用程序中的模块依赖，改为一个全局变量依赖。要实现这些，我们需要使用 `ProvidePlugin` 插件。

使用 [`ProvidePlugin`](/plugins/provide-plugin) 后，能够在 webpack 编译的每个模块中，通过访问一个变量来获取一个 package。如果 webpack 看到模块中用到这个变量，它将在最终 bundle 中引入给定的 package。让我们先移除 `lodash` 的 `import` 语句，改为通过插件提供它：

__src/index.js__

``` diff
- import _ from 'lodash';

  function component() {
    const element = document.createElement('div');

-   // Lodash, now imported by this script
    element.innerHTML = _.join(['Hello', 'webpack'], ' ');

    return element;
  }

  document.body.appendChild(component());
```

__webpack.config.js__

``` diff
  const path = require('path');
+ const webpack = require('webpack');

  module.exports = {
    entry: './src/index.js',
    output: {
      filename: 'bundle.js',
      path: path.resolve(__dirname, 'dist')
-   }
+   },
+   plugins: [
+     new webpack.ProvidePlugin({
+       _: 'lodash'
+     })
+   ]
  };
```

我们本质上所做的，就是告诉 webpack……

> 如果你遇到了至少一处用到 `_` 变量的模块实例，那请你将 `lodash` package 引入进来，并将其提供给需要用到它的模块。

运行我们的构建脚本，将会看到同样的输出：

``` bash
...
    Asset    Size  Chunks                    Chunk Names
bundle.js  544 kB       0  [emitted]  [big]  main
...
```

还可以使用 `ProvidePlugin` 暴露出某个模块中单个导出，通过配置一个“数组路径”（例如 `[module, child, ...children?]`）实现此功能。所以，我们假想如下，无论 `join` 方法在何处调用，我们都只会获取到 `lodash` 中提供的 `join` 方法。

__src/index.js__

``` diff
  function component() {
    const element = document.createElement('div');

-   element.innerHTML = _.join(['Hello', 'webpack'], ' ');
+   element.innerHTML = join(['Hello', 'webpack'], ' ');

    return element;
  }

  document.body.appendChild(component());
```

__webpack.config.js__

``` diff
  const path = require('path');
  const webpack = require('webpack');

  module.exports = {
    entry: './src/index.js',
    output: {
      filename: 'bundle.js',
      path: path.resolve(__dirname, 'dist')
    },
    plugins: [
      new webpack.ProvidePlugin({
-       _: 'lodash'
+       join: ['lodash', 'join']
      })
    ]
  };
```

这样就能很好的与 [tree shaking](/guides/tree-shaking) 配合，将 `lodash` library 中的其余没有用到的导出去除。

## Node 内置

像 `process` 这种 Node 内置模块，能直接根据配置文件进行正确的 polyfill，而不需要任何特定的 loader 或者 plugin。查看 [node ](/configuration/node) 配置页面获取更多信息。

