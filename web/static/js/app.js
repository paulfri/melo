import React from 'react'
import ReactDOM from 'react-dom'
import { Router, Route, browserHistory } from 'react-router'
import Melo from 'Melo'
import Elo from 'pages/Elo'
import Standings from 'pages/Standings'

const NoMatch = () => (
  <main>not found!!!</main>
)

const App = () => (
  <Router history={browserHistory}>
    <Route path='/' component={Melo}>
      <Route path='/elo' component={Elo} />
      <Route path='/elo/:year' component={Elo} />
      <Route path='/standings' component={Standings} />
      <Route path='/standings/:year' component={Standings} />
      <Route path='*' component={NoMatch} />
    </Route>
  </Router>
)

ReactDOM.render(
  <App />,
  document.getElementById('melo')
)
