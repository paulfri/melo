import React from 'react'
import { browserHistory } from 'react-router'
import EloTable from 'components/EloTable'
import YearSelect from 'components/YearSelect'

export default class Elo extends React.Component {
  constructor(props) {
    super()

    this.state = {
      ratings: []
    }
  }

  componentDidMount = () => this.update(this.props.params.year || 2016)

  handleChange = event => this.update(event.target.value)

  update = year => {
    fetch(`/api/elo?year=${year}`)
      .then(response => response.json())
      .then(data => this.setState({ratings: data}))
      .then(() => browserHistory.push(`/elo/${year}`))
  }

  render () {
    return (
      <section className='container'>
        <div className='row'>
          <h2 className='column column-75'>Elo</h2>

          <div className='column column-25'>
            <YearSelect
              onChange={year => this.update(year)}
              selected={this.props.params.year}
            />
          </div>
        </div>

        <EloTable ratings={this.state.ratings} />
      </section>
    )
  }
}
