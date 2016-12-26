import React from 'react'
import EloTable from './components/EloTable'
import YearSelect from './components/YearSelect'

export default class Melo extends React.Component {
  constructor(props) {
    super()

    this.state = {
      ratings: []
    }
  }

  componentDidMount = () => this.update(2016)

  handleChange = event => this.update(event.target.value)

  update = year => {
    fetch(`/api/elo?year=${year}`)
      .then(response => response.json())
      .then(data => this.setState({ratings: data}))
  }

  render () {
    return (
      <div className='container'>
        <div className='row'>
          <h1 className='column'>Melo</h1>
        </div>

        <hr />

        <div className='row'>
          <h2 className='column column-75'>Elo</h2>

          <div className='column column-25'>
            <YearSelect
              onChange={year => this.update(year)}
            />
          </div>
        </div>

        <EloTable
          ratings={this.state.ratings}
        />
      </div>
    )
  }
}
