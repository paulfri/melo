import React from 'react'
import { browserHistory } from 'react-router'
import StandingsTable from 'components/StandingsTable'
import YearSelect from 'components/YearSelect'

export default class Elo extends React.Component {
  constructor(props) {
    super()

    this.state = {
      standings: []
    }
  }

  componentDidMount = () => this.update(this.props.params.year || 2016)

  handleChange = event => this.update(event.target.value)

  update = year => {
    fetch(`/api/standings?year=${year}&type=division`)
      .then(response => response.json())
      .then(data => this.setState({standings: data}))
      .then(() => browserHistory.push(`/standings/${year}`))
  }

  render () {
    return (
      <section className='container'>
        <div className='row'>
          <h2 className='column column-75'>Standings</h2>

          <div className='column column-25'>
            <YearSelect
              onChange={year => this.update(year)}
              selected={this.props.params.year}
            />
          </div>
        </div>

        <p>
          Standings prior to the 2000 season aren't accurate yet.
          Tiebreakers also aren't taken into account.
        </p>

        {this.state.standings.map(st => (
          <StandingsTable
            key={st.title}
            title={st.title}
            standings={st.standings}
          />
        ))}
      </section>
    )
  }
}
