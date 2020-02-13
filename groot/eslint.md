<!--
 * @motto: motto
 * @Author: haichen
 * @Date: 2020-02-13 16:29:39
 * @LastEditors  : haichen
 * @LastEditTime : 2020-02-13 17:25:04
 -->
## 目标
> 增加对代码的约束，优化代码

## cra集成eslint

#### 第一步 安装依赖包
```
$ npm install -D eslint-config-airbnb-base eslint-config-prettier eslint-plugin-prettier prettier
```

#### 第二步 增加.eslintrc.js和.eslintignore文件

- .eslintrc.js模版
```js
'use strict'

module.exports = {
    env: {
        browser: true,
        node: true,
        es6: true,
    },
    plugins: ['react', 'prettier'],
    globals: {
        location: true,
    },
    overrides: [
        {
            files: ['bin/*.js', 'lib/*.js'],
            excludedFiles: '*.test.js',
            rules: {
                quotes: ['error', 'single'],
            },
        },
    ],
    parser: 'babel-eslint',
    parserOptions: {
        ecmaVersion: 7,
        sourceType: 'module',
        ecmaFeatures: {
            jsx: true,
            modules: true,
        },
    },
    extends: ['airbnb-base', 'prettier', 'prettier/react'],
    rules: {
        'no-underscore-dangle': 1,
        'prefer-destructuring': 1,
        'arrow-body-style': 0,
        'import/no-extraneous-dependencies': 0,
        'import/extensions': 0,
        'prefer-const': 0,
        'no-unused-expressions': [
            1,
            {
                allowShortCircuit: true,
            },
        ],
        'no-empty': [
            2,
            {
                allowEmptyCatch: true,
            },
        ],
        'default-case': 0,
        'no-case-declarations': 0,
        'class-methods-use-this': 0,
        'no-script-url': 0,
        semi: 0,
        'eol-last': 0,
        'no-unused-vars': 1,
        'global-require': 0,
        'react/jsx-uses-react': 2,
        'react/jsx-uses-vars': 2,
        'import/no-unresolved': 0,
        'no-unneeded-ternary': 1,
        'no-nested-ternary': 1,
        'max-len': [2, 150],
        'no-return-assign': 0,
        'dot-notation': 1,
        'no-param-reassign': 1,
        'func-names': 1,
        'no-useless-constructor': 0,
        'no-plusplus': 0,
        'no-param-reassign': 0, 
        'no-multi-assign': 0, 
        'consistent-return': 0, 
    },
}
```

- .eslintignore 模版
```
**/node_modules/**
**/config/**
```

#### 第三步 删除package.json多余配置
```
...
- "eslintConfig": {
-    "extends": "react-app"
-  },
"browserslist": {
  "production": [
    ">0.2%",
    "not dead",
    "not op_mini all"
  ],
  "development": [
    "last 1 chrome version",
    "last 1 firefox version",
    "last 1 safari version"
  ]
},
...
```

## 最终效果
![](https://img.kaikeba.com/40717131200202jgdr.png)
## cli 使用eslint
```
$ npm i -g eslint
```