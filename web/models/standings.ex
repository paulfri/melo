# TODO: this is very similar to the Melo.Elo module. combine the code somehow
defmodule Melo.Standings do
  @moduledoc """
  Functions for retrieving historical league standings for results in the Melo
  database.
  """

  import Ecto.Query, only: [from: 2]

  defmodule StandingsEntry do
    defstruct team_season: nil, games_played: 0, points: 0, wins: 0, losses: 0,
      draws: 0, home_wins: 0, home_losses: 0, home_draws: 0, away_wins: 0,
      away_losses: 0, away_draws: 0, goals_for: 0, goals_against: 0
  end

  @doc """
  Get the standings for a given MLS season.
  """
  def season(year) do
    standings = retrieve_team_seasons(year)
    |> Enum.map(fn team_season -> %StandingsEntry{team_season: team_season} end)

    retrieve_matches(year)
    |> Enum.reduce(standings, &generate_standings/2)
    |> Enum.sort_by(fn entry -> entry.points end)
    |> Enum.reverse
  end

  # returns new standings with the given match included
  defp generate_standings(match, standings) do
    home_index = standings
    |> Enum.find_index(fn stats -> stats.team_season == match.home end)
    away_index = standings
    |> Enum.find_index(fn stats -> stats.team_season == match.away end)

    home_entry = Enum.at(standings, home_index)
    |> update_standings_entry(match.home_score, match.away_score, true)
    away_entry = Enum.at(standings, away_index)
    |> update_standings_entry(match.away_score, match.home_score, false)

    standings
    |> List.replace_at(home_index, home_entry)
    |> List.replace_at(away_index, away_entry)
  end

  defp update_standings_entry(entry, score, opponent_score, home) do
    result = calculate_result(score, opponent_score)

    struct(entry, %{
      games_played: entry.games_played + 1,
      points: entry.points + calculate_points(result),
      wins: (entry.wins + if (result == :win), do: 1, else: 0),
      losses: (entry.losses + if (result == :loss), do: 1, else: 0),
      draws: (entry.draws + if (result == :draw), do: 1, else: 0),
      home_wins: (entry.home_wins + if (result == :win && home), do: 1, else: 0),
      home_losses: (entry.home_losses + if (result == :loss && home), do: 1, else: 0),
      home_draws: (entry.home_draws + if (result == :draw && home), do: 1, else: 0),
      away_wins: (entry.away_wins + if (result == :win && !home), do: 1, else: 0),
      away_losses: (entry.away_losses + if (result == :loss && !home), do: 1, else: 0),
      away_draws: (entry.away_draws + if (result == :draw && !home), do: 1, else: 0),
      goals_for: entry.goals_for + score,
      goals_against: entry.goals_against + opponent_score
    })
  end

  defp calculate_result(score, opponent_score) do
    cond do
      score > opponent_score ->
        :win
      score < opponent_score ->
        :loss
      true ->
        :draw
    end
  end

  # TODO: account for shootouts pre-2001
  defp calculate_points(result) do
    case result do
      :win  -> 3
      :loss -> 0
      :draw -> 1
    end
  end

  defp retrieve_team_seasons(year) do
    Melo.Repo.all(
      from ts in Melo.TeamSeason,
      join: d in Melo.Division, where: ts.division_id == d.id,
      join: s in Melo.Season, where: s.id == d.season_id,
      join: t in Melo.Team, where: ts.team_id == t.id,
      where: s.year == ^year,
      select: ts
    )
    |> Melo.Repo.preload(:team)
  end

  defp retrieve_matches(year) do
    {:ok, start_date} = Date.from_erl({year, 1, 1})
    {:ok, end_date} = Date.from_erl({year + 1, 1, 1})

    Melo.Repo.all(
      from m in Melo.Match,
      where: m.date >= ^start_date,
      where: m.date <  ^end_date
    )
    |> Melo.Repo.preload(:home)
    |> Melo.Repo.preload(home: :team)
    |> Melo.Repo.preload(:away)
    |> Melo.Repo.preload(away: :team)
  end
end
