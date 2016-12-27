import React, { PropType } from 'react'

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
  title: PropType.string.isRequired,
  standings: PropType.arrayOf(PropType.shape({
    team: PropType.shape({
      name: PropType.string.isRequired,
      abbreviation: PropType.string.isRequired
    }).isRequired,
    points: PropType.number.isRequired,
    games_played: PropType.number.isRequired,
    wins: PropType.number.isRequired,
    losses: PropType.number.isRequired,
    draws: PropType.number.isRequired,
    home_wins: PropType.number.isRequired,
    home_losses: PropType.number.isRequired,
    home_draws: PropType.number.isRequired,
    away_wins: PropType.number.isRequired,
    away_losses: PropType.number.isRequired,
    away_draws: PropType.number.isRequired,
    goals_for: PropType.number.isRequired,
    goals_against: PropType.number.isRequired
  }))
}

export default StandingsTable
