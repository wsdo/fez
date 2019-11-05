---
title: tree shaking
sort: 7
contributors:
  - simon04
  - zacanger
  - alexjoverm
  - avant1
  - MijaelWatts
  - dmitriid
  - probablyup
  - gish
  - lumo10
  - byzyk
  - pnevares
  - EugeneHlushko
  - torifat
related:
  - title: "webpack 4 beta — try it today!"
    url: https://medium.com/webpack/webpack-4-beta-try-it-today-6b1d27d7d7e2#9a67
  - title: Debugging Optimization Bailouts
    url: https://webpack.js.org/plugins/module-concatenation-plugin/#debugging-optimization-bailouts
  - title: Issue 6074 - Add support for more complex selectors for sideEffects
    url: https://github.com/webpack/webpack/issues/6074
---

_tree shaking_ 是一个术语，通常用于描述移除 JavaScript 上下文中的未引用代码(dead-code)。它依赖于 ES2015 模块语法的 [静态结构](http://exploringjs.com/es6/ch_modules.html#static-module-structure) 特性，例如 [`import`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import) 和 [`export`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export)。这个术语和概念实际上是由 ES2015 模块打包工具 [rollup](https://github.com/rollup/rollup) 普及起来的。

webpack 2 正式版本内置支持 ES2015 模块（也叫做 _harmony modules_）和未使用模块检测能力。新的 webpack 4 正式版本扩展了此检测能力，通过 `package.json` 的 `"sideEffects"` 属性作为标记，向 compiler 提供提示，表明项目中的哪些文件是 "pure(纯的 ES2015 模块)"，由此可以安全地删除文件中未使用的部分。

T> 本指南的继承自 [起步](/guides/getting-started) 指南。如果你尚未阅读该指南，请先行阅读。


## 添加一个通用模块

在我们的项目中添加一个新的通用模块文件 `src/math.js`，并导出两个函数：

__project__

``` diff
webpack-demo
|- package.json
|- webpack.config.js
|- /dist
  |- bundle.js
  |- index.html
|- /src
  |- index.js
+ |- math.js
|- /node_modules
```

__src/math.js__

```javascript
export function square(x) {
  return x * x;
}

export function cube(x) {
  return x * x * x;
}
```

将 `mode` 配置选项设置为 [development](/concepts/mode/#mode-development) 以确保 bundle 是未压缩版本：

__webpack.config.js__

``` diff
const path = require('path');

module.exports = {
  entry: './src/index.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist')
- }
+ },
+ mode: 'development',
+ optimization: {
+   usedExports: true
+ }
};
```

配置完这些后，更新入口脚本，使用其中一个新方法，并且为了简化示例，我们先将 `lodash` 删除：

__src/index.js__

``` diff
- import _ from 'lodash';
+ import { cube } from './math.js';

  function component() {
-   var element = document.createElement('div');
+   var element = document.createElement('pre');

-   // lodash 是由当前 script 脚本 import 进来的
-   element.innerHTML = _.join(['Hello', 'webpack'], ' ');
+   element.innerHTML = [
+     'Hello webpack!',
+     '5 cubed is equal to ' + cube(5)
+   ].join('\n\n');

    return element;
  }

  document.body.appendChild(component());
```

注意，我们__没有从 `src/math.js` 模块中 `import` 另外一个 `square` 方法__。这个函数就是所谓的“未引用代码(dead code)”，也就是说，应该删除掉未被引用的 `export`。现在运行 npm script `npm run build`，并查看输出的 bundle：

__dist/bundle.js (around lines 90 - 100)__

```js
/* 1 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {
  'use strict';
  /* unused harmony export square */
  /* harmony export (immutable) */ __webpack_exports__['a'] = cube;
  function square(x) {
    return x * x;
  }

  function cube(x) {
    return x * x * x;
  }
});
```

注意，上面的 `unused harmony export square` 注释。如果你观察它下面的代码，你会注意到虽然我们没有引用 `square`，但它仍然被包含在 bundle 中。我们将在下一节解决这个问题。


## 将文件标记为 side-effect-free(无副作用)

在一个纯粹的 ESM 模块世界中，很容易识别出哪些文件有 side effect。然而，我们的项目无法达到这种纯度，所以，此时有必要提示 webpack compiler 哪些代码是“纯粹部分”。

通过 package.json 的 `"sideEffects"` 属性，来实现这种方式。

```json
{
  "name": "your-project",
  "sideEffects": false
}
```

如果所有代码都不包含 side effect，我们就可以简单地将该属性标记为 `false`，来告知 webpack，它可以安全地删除未用到的 export。

T> "side effect(副作用)" 的定义是，在导入时会执行特殊行为的代码，而不是仅仅暴露一个 export 或多个 export。举例说明，例如 polyfill，它影响全局作用域，并且通常不提供 export。

如果你的代码确实有一些副作用，可以改为提供一个数组：

```json
{
  "name": "your-project",
  "sideEffects": [
    "./src/some-side-effectful-file.js"
  ]
}
```

数组方式支持相对路径、绝对路径和 glob 模式匹配相关文件。它在内部使用 [micromatch](https://github.com/micromatch/micromatch#matching-features)。

T> 注意，所有导入文件都会受到 tree shaking 的影响。这意味着，如果在项目中使用类似 `css-loader` 并 import 一个 CSS 文件，则需要将其添加到 side effect 列表中，以免在生产模式中无意中将它删除：

```json
{
  "name": "your-project",
  "sideEffects": [
    "./src/some-side-effectful-file.js",
    "*.css"
  ]
}
```

最后，还可以在 [`module.rules` 配置选项](/configuration/module/#module-rules) 中设置 `"sideEffects"`。

## 压缩输出结果

通过 `import` 和 `export`  语法，我们已经找出需要删除的“未引用代码(dead code)”，然而，不仅仅是要找出，还要在 bundle 中删除它们。为此，我们需要将 `mode` 配置选项设置为 [`production`](/concepts/mode/#mode-production)。

__webpack.config.js__

``` diff
const path = require('path');

module.exports = {
  entry: './src/index.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist')
  },
- mode: 'development',
- optimization: {
-   usedExports: true
- }
+ mode: 'production'
};
```

T> 注意，也可以在命令行接口中使用 `--optimize-minimize` 标记，来启用 `TerserPlugin`。

准备就绪后，然后运行另一个 npm script `npm run build`，看看输出结果是否发生改变。

你发现 `dist/bundle.js` 中的差异了吗？显然，现在整个 bundle 都已经被 minify(压缩) 和 mangle(混淆破坏)，但是如果仔细观察，则不会看到引入 `square` 函数，但能看到 `cube` 函数的混淆破坏版本（`function r(e){return e*e*e}n.a=r`）。现在，随着 minification(代码压缩) 和 tree shaking，我们的 bundle 减小几个字节！虽然，在这个特定示例中，可能看起来没有减少很多，但是，在有着复杂依赖树的大型应用程序上运行 tree shaking 时，会对 bundle 产生显著的体积优化。

T> 运行 tree shaking 需要 [ModuleConcatenationPlugin](/plugins/module-concatenation-plugin)。通过 `mode: "production"` 可以添加此插件。如果你没有使用 mode 设置，记得手动添加 [ModuleConcatenationPlugin](/plugins/module-concatenation-plugin)。

## 结论

我们已经知道，想要使用 _tree shaking_ 必须注意以下……

- 使用 ES2015 模块语法（即 `import` 和 `export`）。
- 确保没有 compiler 将 ES2015 模块语法转换为 CommonJS 模块（这也是流行的 Babel preset 中 @babel/preset-env 的默认行为 - 更多详细信息请查看 [文档](https://babel.docschina.org/docs/en/babel-preset-env#modules)）。
- 在项目 `package.json` 文件中，添加一个 "sideEffects" 属性。
- 通过将 `mode` 选项设置为 [`production`](/concepts/mode/#mode-production)，启用 minification(代码压缩) 和 tree shaking。

你可以将应用程序想象成一棵树。绿色表示实际用到的 source code(源码) 和 library(库)，是树上活的树叶。灰色表示未引用代码，是秋天树上枯萎的树叶。为了除去死去的树叶，你必须摇动这棵树，使它们落下。

如果你对优化输出很感兴趣，请进入到下个指南，来了解 [生产环境](/guides/production) 构建的详细细节。
