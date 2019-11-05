---
title: 摘要
---

## 摘要

如果你不想阅读整篇文章，可以快速浏览这份摘要。要是某些部分不容易理解，你可以往下滚动寻找相关的内容去阅读。

如果你打算阅读整篇文章，你完全可以跳过这部分。我会在文章末尾带上摘要的链接。

**🤔 Question: 如何用`useEffect`模拟`componentDidMount`生命周期？**

虽然可以使用`useEffect(fn, [])`，但它们并不完全相等。和`componentDidMount`不一样，`useEffect`会*捕获* props和state。所以即便在回调函数里，你拿到的还是初始的props和state。如果你想得到“最新”的值，你可以使用ref。不过，通常会有更简单的实现方式，所以你并不一定要用ref。记住，effects的心智模型和`componentDidMount`以及其他生命周期是不同的，试图找到它们之间完全一致的表达反而更容易使你混淆。想要更有效，你需要“think in effects”，它的心智模型更接近于实现状态同步，而不是响应生命周期事件。


**🤔 Question: 如何正确地在`useEffect`里请求数据？`[]`又是什么？**

[这篇文章](https://www.robinwieruch.de/react-hooks-fetch-data/) 是很好的入门，介绍了如何在`useEffect`里做数据请求。请务必读完它！它没有我的这篇这么长。`[]`表示effect没有使用任何React数据流里的值，因此该effect仅被调用一次是安全的。`[]`同样也是一类常见问题的来源，也即你以为没使用数据流里的值但其实使用了。你需要学习一些策略（主要是`useReducer` 和 `useCallback`）来移除这些effect依赖，而不是错误地忽略它们。

**🤔 Question: 我应该把函数当做effect的依赖吗？**

一般建议把不依赖props和state的函数提到你的组件外面，并且把那些仅被effect使用的函数放到effect里面。如果这样做了以后，你的effect还是需要用到组件内的函数（包括通过props传进来的函数），可以在定义它们的地方用`useCallback`包一层。为什么要这样做呢？因为这些函数可以访问到props和state，因此它们会参与到数据流中。我们官网的FAQ有[更详细的答案](https://reactjs.org/docs/hooks-faq.html#is-it-safe-to-omit-functions-from-the-list-of-dependencies)。


**🤔 Question: 为什么有时候会出现无限重复请求的问题？**

这个通常发生于你在effect里做数据请求并且没有设置effect依赖参数的情况。没有设置依赖，effect会在每次渲染后执行一次，然后在effect中更新了状态引起渲染并再次触发effect。无限循环的发生也可能是因为你设置的依赖总是会改变。你可以通过一个一个移除的方式排查出哪个依赖导致了问题。但是，移除你使用的依赖（或者盲目地使用`[]`）通常是一种错误的解决方式。你应该做的是解决问题的根源。举个例子，函数可能会导致这个问题，你可以把它们放到effect里，或者提到组件外面，或者用`useCallback`包一层。`useMemo` 可以做类似的事情以避免重复生成对象。


**🤔 为什么有时候在effect里拿到的是旧的state或prop呢？**

Effect拿到的总是定义它的那次渲染中的props和state。这能够[避免一些bugs](/how-are-function-components-different-from-classes/)，但在一些场景中又会有些讨人嫌。对于这些场景，你可以明确地使用可变的ref保存一些值（上面文章的末尾解释了这一点）。如果你觉得在渲染中拿到了一些旧的props和state，且不是你想要的，你很可能遗漏了一些依赖。可以尝试使用这个[lint 规则](https://github.com/facebook/react/issues/14920)来训练你发现这些依赖。可能没过几天，这种能力会变得像是你的第二天性。同样可以看我们官网FAQ中的[这个回答。](https://reactjs.org/docs/hooks-faq.html#why-am-i-seeing-stale-props-or-state-inside-my-function)

---

我希望这个摘要对你有所帮助！要不，我们开始正文。

---
