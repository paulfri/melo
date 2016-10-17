defmodule Mix.Tasks.ImportMatches do
  alias Ecto.Adapters.SQL
  alias Ecto.Date
  alias Melo.Match
  alias Melo.Repo
  alias Melo.Scraper
  alias Melo.TeamSeason
  import Ecto.Query
  use Mix.Task

  def run(_params) do
    {:ok, _started} = Application.ensure_all_started(:melo)

    SQL.query(Repo, "truncate table matches")

    matches = (1996..2015)
    |> Enum.flat_map(fn(year) ->
      Scraper.scrape(year)
    end)

    Repo.transaction(fn ->
      Enum.each(matches, fn(match) ->
        home = team_season(match.home, match.date)
        away = team_season(match.away, match.date)

        Repo.insert!(%Match{
          home: home,
          away: away,
          home_score: match.home_score,
          away_score: match.away_score,
          date: Date.cast!(match.date)
        })
      end)
    end)
  end

  defp team_season(name, date) do
    year = date
           |> String.slice(0..3)
           |> String.to_integer

    query = TeamSeason
            |> join(:inner, [ts], t in assoc(ts, :team))
            |> join(:inner, [ts], d in assoc(ts, :division))
            |> join(:inner, [ts, _t, d], s in assoc(d, :season))
            |> where([_ts, t], t.name == ^name)
            |> where([_ts, _t, _d, s], s.year == ^year)

    Repo.one!(query)
  end
end
