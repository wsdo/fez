---
sidebarDepth: 4
pageClass: custom-code-highlight
---


#### 项目sentry环境配置


#### utils/sentry.js
```js
import { envObj, getEnv } from './env'
const { DEV, TEST, PRE, PROD } = envObj
const devDSN = 'https:// '
const prodDSN = 'https:// '
const preDSN = 'https:// '
const testDSN = 'https:// '

const DSN = { dev: devDSN, prod: prodDSN, test: testDSN, pre: preDSN }
console.log('current env', getEnv)
export default DSN[getEnv]

```
