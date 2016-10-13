defmodule Mix.Tasks.Import do
  alias Melo.Match
  alias Melo.Team
  alias Melo.Venue
  alias Melo.Repo
  use Mix.Task

  def run(year) do
    {:ok, _started} = Application.ensure_all_started(:melo)

    Mix.shell.info "Importing matches for #{year}"

    # TODO: delete matches from the given year

    matches = Melo.Scraper.scrape(year)

    IO.inspect(matches)

    teams = matches
      |> Enum.flat_map(fn(x) -> [x[:home], x[:away]] end)
      |> Enum.uniq

    IO.inspect(teams)

    venues = matches
      |> Enum.map(fn(x) -> x[:venue] end)
      |> Enum.uniq

    IO.inspect(venues)

    Repo.transaction(fn ->
      Enum.each(matches, fn(match) ->
        venue = case Repo.get_by(Venue, name: match.venue) do
          nil   -> Repo.insert!(%Venue{name: match.venue, location: "foo"})
          venue -> venue
        end

        home = case Repo.get_by(Team, name: match.home) do
          nil  -> Repo.insert!(%Team{name: match.home, location: "foo"})
          team -> team
        end

        away = case Repo.get_by(Team, name: match.away) do
          nil  -> Repo.insert!(%Team{name: match.away, location: "foo"})
          team -> team
        end

        Repo.insert!(%Match{
          venue: venue,
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
