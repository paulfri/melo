defmodule Melo.Elo do
  @moduledoc """
  Functions for retrieving Elo rating data for results in the Melo database.
  """

  @default_elo_rating 1500
  @default_k_factor 35

  import Ecto.Query, only: [from: 2]

  @doc """
  Get the Elo ratings for a given MLS season.

  Returns a sorted keyword list, keyed by team abbreviation, with the team's
  Elo rating for that season as the value.
  """
  def season(year) do
    # load all the team_seasons from db
    team_seasons = retrieve_team_seasons(year)

    # assign default rating to each team
    ratings = Enum.zip(
      Enum.map(team_seasons, &key/1),
      (for _ <- 1..20, do: @default_elo_rating)
    )

    # load all matches from db
    matches = retrieve_matches(year)

    # iterate through matches and track team ratings in the accumulator
    new_ratings = Enum.reduce(matches, ratings, fn(match, new_ratings) ->
      {new_home, new_away} = rate_match(
        new_ratings[key(match.home)],
        new_ratings[key(match.away)],
        match
      )

      Keyword.merge(new_ratings, [
        {key(match.home), new_home},
        {key(match.away), new_away}
      ])
    end)

    # return sorted, in format: %{ team: Team, rating: 123 }
    new_ratings
    |> Enum.map(fn({abbrev, rating}) ->
      a = abbrev
      |> Atom.to_string
      |> String.upcase

      team_season = Enum.find(team_seasons, fn ts -> ts.team.abbreviation == a end)

      %{team_season: team_season,
        rating: rating}
    end)
    |> Enum.sort_by(fn %{rating: rating} -> rating end)
    |> Enum.reverse
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

  defp key(team_season) do
    team_season.team.abbreviation
    |> String.downcase
    |> String.to_atom
  end

  defp rate_match(home_elo, away_elo, match) do
    result = cond do
      match.home_score > match.away_score ->
        :win
      match.away_score > match.home_score ->
        :loss
      true ->
        :draw
    end

    Elo.rate(home_elo, away_elo, result, k_factor: @default_k_factor)
  end
end
