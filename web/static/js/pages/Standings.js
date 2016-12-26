import React from 'react'
import StandingsTable from 'components/StandingsTable'
import YearSelect from 'components/YearSelect'

export default class Standings extends React.Component {
  render () {
    return (
      <section className='container'>
        <div className='row'>
          <h2 className='column column-75'>Standings</h2>

          <div className='column column-25'>
            <YearSelect />
          </div>
        </div>

        <StandingsTable
          title={'Eastern Conference'}
        />

        <StandingsTable
          title={'Western Conference'}
        />
      </section>
    )
  }
}
