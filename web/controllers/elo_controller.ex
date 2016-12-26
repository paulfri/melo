defmodule Melo.EloController do
  use Melo.Web, :controller

  def index(conn, %{"year" => year}) do
    {year, _} = Integer.parse(year)
    ratings = Melo.Elo.season(year)

    render(conn, "index.json", ratings: ratings)
  end
end
