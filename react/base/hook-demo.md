```
import React, { useState, useEffect } from "react";
import ReactDOM from "react-dom";
import "./styles.css";

const CounterHook = () => {
  const [count, setCount] = useState(0);
  const [name, setName] = useState("heaven");

  useEffect(() => {
    document.title = `counterWithHook ${count}`;
  }, [count]);

  useEffect(() => {
    console.log("you name is", name);
  }, [name]);

  return (
    <div>
      <h3>Counter with Hook</h3>
      <p>You click {count} times</p>
      <button onClick={e => setCount(count => count + 1)}>Click me</button>
      <p>
        <input placeholder="输入姓名" onChange={e => setName(e.target.value)} />
        <br />
        your name is {name}
      </p>
    </div>
  );
};

class CounterClass extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      count: 0
    };
  }

  setCount = () => {
    this.setState(prevState => ({
      count: prevState.count + 1
    }));
  };

  render() {
    const { count } = this.state;
    return (
      <div>
        <h3>Counter with Class</h3>
        <p>You click {count} times</p>
        <button onClick={this.setCount}>Click me</button>
      </div>
    );
  }
}

function App() {
  return (
    <div className="App">
      <CounterHook />
      <hr />
      <CounterClass />
    </div>
  );
}

const rootElement = document.getElementById("root");
ReactDOM.render(<App />, rootElement);

```
