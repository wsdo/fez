---
title: webpackjs性能优化：DllPlugin插件详细使用方式
categories: "webpack"
---

<!-- ![20200212135056](http://s.shudong.wang/shudong/20200212135056.png) -->
![20200212135158](http://s.shudong.wang/shudong/20200212135158.png)

> 永久链接： https://shudong.wang/10731.html

## 概念
> 把每次打包不需要变动的文件（一般类库，如:react,lodash）提前打包好，这样每次打包项目的时候，就不需要单独打包这些文件，从而节约了时间

## dll Plugin
https://www.npmjs.com/package/add-asset-html-webpack-plugin

#### 正常构建

>Hash: daa3610a1f7e6d32873d
Version: webpack 4.41.5
Time: 4212ms
Built at: 02/10/2020 6:59:16 PM

![20200210185958](http://s.shudong.wang/shudong/20200210185958.png)

#### 构建完dll
> Hash: eca9917dfce14b9c2876
Version: webpack 4.41.5
Time: 2742ms
Built at: 02/10/2020 7:00:45 PM

![20200210190105](http://s.shudong.wang/shudong/20200210190105.png)

#### 再次build
> Hash: a528e9cbdaefb8a893cc
Version: webpack 4.41.5
Time: 1154ms
Built at: 02/10/2020 7:01:16 PM

![20200210190136](http://s.shudong.wang/shudong/20200210190136.png)

#### 节省
4212-1154=3058ms

## 使用方式
> 单独创建一个webpack文件， webpack.dll.js  专门用来，打包dll包相关
```
module.exports = {
  mode: "production",
  ...
  plugins: [
    new webpack.DllPlugin({
      name: "[name]",
      path: path.resolve(__dirname, "../dll/[name].manifest.json")
    })
  ]
};
```

#### webpack.DllPlugin
> 此插件用于单独的webpack配置中，专门用于创建dll-only-bundle。它创建了一个清单。json文件，DllReferencePlugin使用它来映射依赖项。

#### 参数如下：
* context (optional): context of requests in the manifest file (defaults to the webpack context.)
* name: name of the exposed dll function (TemplatePaths: [hash] & [name] )
* path: absolute path to the manifest json file (output)
* entryOnly (boolean = true): if true, only entry points will be exposed
* type: type of the dll bundle


#### DllReferencePlugin 打包完成后，在项目中做对应关系使用插件 
This plugin is used in the primary webpack config, it references the dll-only-bundle(s) to require pre-built dependencies.
CHINESE (SIMPLIFIED)
该插件在主要的webpack配置中使用，它引用dll-only-bundle以要求预先构建的依赖项。

#### 参数如下：
- context: (absolute path) context of requests in the manifest (or content property)
- manifest : an object containing content and name or a string to the absolute path of the JSON manifest to be loaded upon compilation
- content (optional): the mappings from request to module id (defaults to manifest.content)
- name (optional): an identifier where the dll is exposed (defaults to manifest.name) (see also externals)
- scope (optional): prefix which is used for accessing the content of the dll
- sourceType (optional): how the dll is exposed (libraryTarget)

#### DllReferencePlugin demo参考：
```
new webpack.DllReferencePlugin({
  manifest: path.resolve(__dirname, "../dll", '符合条件的文件')
})
```

> 在打包的webpack中，使用了这个插件，每次打包就会取，dll 里面的文件，避免重复打包

#### AddAssetHtmlWebpackPlugin ：这时候打包完毕后，没有把相关的js引用到html当中，需要使用这个插件
* 参考：https://www.npmjs.com/package/add-asset-html-webpack-plugin
* 将JavaScript或CSS资产添加到html-webpack-plugin生成的HTML中


## webpack.dll.js 全部代码参考
```
const path = require("path");
const webpack = require("webpack");
module.exports = {
  mode: "production",
  entry: {
    vendors: ["lodash"],
    react: ["react", "react-dom"],
    jquery: ["jquery"]
  },
  output: {
    filename: "[name].dll.js",
    path: path.resolve(__dirname, "../dll"),
    library: "[name]"
  },
  plugins: [
    new webpack.DllPlugin({
      name: "[name]",
      path: path.resolve(__dirname, "../dll/[name].manifest.json")
    })
  ]
};
```

## 参考资料
* https://webpack.js.org/plugins/dll-plugin/
* https://www.npmjs.com/package/add-asset-html-webpack-plugin
* https://gitlab.com/webpackjs

## 文章对应的仓库
> https://gitlab.com/webpackjs/webpack-dll-demo.git 
> 备注：需要在https://shudong.wang/about 联系作者 添加权限
