---
pageClass: custom-code-highlight,
title: 'react集成模板'
---

## react集成模板

```
import React, { PureComponent } from 'react'
import PropTypes from 'prop-types'
import echarts from 'echarts'

export default class Base extends PureComponent {
  static defaultProps = {
    onChange() {}
  }
  static contextTypes = {
    styles: PropTypes.object
  }

  constructor(props) {
    super(props)
    this.state = {
      name:'stark'
    }
  }
}

```
