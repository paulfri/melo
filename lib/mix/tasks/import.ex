defmodule Mix.Tasks.Import do
  alias Melo.Match
  alias Melo.Team
  alias Melo.Repo
  use Mix.Task

  def run(_params) do
    {:ok, _started} = Application.ensure_all_started(:melo)

    Ecto.Adapters.SQL.query(Repo, "truncate table matches")

    matches = (1996..2015)
    |> Enum.flat_map(fn(year) -> Melo.Scraper.scrape(year) end)

    Repo.transaction(fn ->
      Enum.each(matches, fn(match) ->
        home = Repo.get_by!(Team, name: match.home)
        away = Repo.get_by!(Team, name: match.away)

        Repo.insert!(%Match{
          home: home,
          away: away,
          home_score: match.home_score,
          away_score: match.away_score,
          date: Ecto.Date.cast!(match.date)
        })
      end)
    end)
  end
end
