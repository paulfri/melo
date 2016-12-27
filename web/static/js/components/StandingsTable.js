import React, { PropTypes } from 'react'

const StandingsTable = ({title, standings}) => (
  <section>
    <h3>{title}</h3>

    <table className='standings'>
      <thead>
        <tr>
          <th colSpan='2' className='standings__super-head--empty' />
          <th colSpan='2' className='standings__super-head'>Points</th>
          <th colSpan='4' className='standings__super-head--empty' />
          <th colSpan='3' className='standings__super-head'>Home</th>
          <th colSpan='3' className='standings__super-head'>Away</th>
          <th colSpan='3' className='standings__super-head--empty' />
        </tr>
        <tr>
          <th>Rank</th>
          <th>Team</th>
          <th>Points</th>
          <th>PPG</th>
          <th>GP</th>
          <th>W</th>
          <th>L</th>
          <th>T</th>
          <th>W</th>
          <th>L</th>
          <th>T</th>
          <th>W</th>
          <th>L</th>
          <th>T</th>
          <th>GF</th>
          <th>GA</th>
          <th>GD</th>
        </tr>
      </thead>

      <tbody>
        {standings.map((s, i) => (
          <tr key={i + 1}>
            <td>{i + 1}</td>
            <td>{s.team.name}</td>
            <td><strong>{s.points}</strong></td>
            <td>{(s.points / s.games_played).toFixed(2)}</td>
            <td>{s.games_played}</td>
            <td>{s.wins}</td>
            <td>{s.losses}</td>
            <td>{s.draws}</td>
            <td>{s.home_wins}</td>
            <td>{s.home_losses}</td>
            <td>{s.home_draws}</td>
            <td>{s.away_wins}</td>
            <td>{s.away_losses}</td>
            <td>{s.away_draws}</td>
            <td>{s.goals_for}</td>
            <td>{s.goals_against}</td>
            <td>{s.goals_for - s.goals_against}</td>
          </tr>
        ))}
      </tbody>
    </table>
  </section>
)

StandingsTable.propTypes = {
  title: PropTypes.string.isRequired,
  standings: PropTypes.arrayOf(PropTypes.shape({
    team: PropTypes.shape({
      name: PropTypes.string.isRequired,
      abbreviation: PropTypes.string.isRequired
    }).isRequired,
    points: PropTypes.number.isRequired,
    games_played: PropTypes.number.isRequired,
    wins: PropTypes.number.isRequired,
    losses: PropTypes.number.isRequired,
    draws: PropTypes.number.isRequired,
    home_wins: PropTypes.number.isRequired,
    home_losses: PropTypes.number.isRequired,
    home_draws: PropTypes.number.isRequired,
    away_wins: PropTypes.number.isRequired,
    away_losses: PropTypes.number.isRequired,
    away_draws: PropTypes.number.isRequired,
    goals_for: PropTypes.number.isRequired,
    goals_against: PropTypes.number.isRequired
  }))
}

export default StandingsTable
