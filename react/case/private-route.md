## 私有路由实现方案

```
import React from 'react'
import { Route, Redirect } from 'react-router-dom'

const PrivateRoute = ({ component: Component, isPrivate, ...rest }) => (
  <Route
    {...rest}
    render={props =>
      isPrivate ? (
        <Component {...props} />
      ) : (
        <Redirect
          to={{
            pathname: '/notFound',
            state: { from: props.location }
          }}
        />
      )
    }
  />
)
export default PrivateRoute

```
