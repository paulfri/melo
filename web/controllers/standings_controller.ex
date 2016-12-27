defmodule Melo.StandingsController do
  use Melo.Web, :controller

  def index(conn, %{"year" => year, "type" => type}) do
    {year, _} = Integer.parse(year)

    standings = Melo.Standings.season(year, type)

    render(conn, "index.json", standings: standings)
  end

  def index(conn, %{"year" => year}) do
    index(conn, %{"year" => year, "type" => "league"})
  end

  def index(conn, _params) do
    index(conn, %{"year" => "2016", "type" => "league"})
  end
end
