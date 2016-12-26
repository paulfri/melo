import React, { PropTypes } from 'react'

const EloTable = ({ratings}) => (
  <table>
    <thead>
      <tr>
        <th>Rank</th>
        <th>Team</th>
        <th>Rating</th>
      </tr>
    </thead>

    <tbody>
      {ratings.map((r, index) => (
        <tr key={index + 1}>
          <td>{index + 1}</td>
          <td>{r.team.name}</td>
          <td>{r.rating}</td>
        </tr>
      ))}
    </tbody>
  </table>
)

EloTable.propTypes = {
  ratings: PropTypes.arrayOf(
    PropTypes.shape({
      team: PropTypes.shape({
        name: PropTypes.string,
        abbreviation: PropTypes.string
      }),
      rating: PropTypes.number
    })
  ).isRequired
}

export default EloTable
