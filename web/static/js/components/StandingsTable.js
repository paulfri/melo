import React, { PropTypes } from 'react'

const StandingsTable = ({title, standings}) => (
  <section>
    <h3>{title}</h3>

    <table>
      <thead>
        <tr>
          <th>Rank</th>
          <th>Team</th>
          <th>Points</th>
          <th>PPG</th>
          <th>GP</th>
          <th>W</th>
          <th>L</th>
          <th>T</th>
          <th>GF</th>
          <th>GA</th>
          <th>GD</th>
        </tr>
      </thead>

      <tbody>
      </tbody>
    </table>
  </section>
)

export default StandingsTable
