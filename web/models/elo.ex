defmodule Melo.Elo do
  @moduledoc """
  Functions for retrieving Elo rating data for results in the Melo database.
  """

  alias Melo.Match
  alias Melo.TeamSeason

  @default_elo_rating 1500
  @default_k_factor 35

  @doc """
  Get the Elo ratings for a given MLS season.

  Returns a map with `team_season` and `rating` keys.
  """
  def season(year) do
    team_seasons = TeamSeason.season(year)
    matches = Match.season(year)

    # assign default rating to each team
    ratings = Enum.zip(
      Enum.map(team_seasons, &key/1),
      (for _ <- 1..20, do: @default_elo_rating)
    )

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

      team_season = Enum.find(team_seasons, fn ts ->
        ts.team.abbreviation == a
      end)

      %{team_season: team_season,
        rating: rating}
    end)
    |> Enum.sort_by(fn %{rating: rating} -> rating end)
    |> Enum.reverse
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
