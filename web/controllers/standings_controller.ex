defmodule Melo.StandingsController do
  use Melo.Web, :controller

  def index(conn, %{"year" => year}) do
    {year, _} = Integer.parse(year)
    standings = Melo.Standings.season(year)

    render(conn, "index.json", standings: standings)
  end
end
