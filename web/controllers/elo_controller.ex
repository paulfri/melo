defmodule Melo.EloController do
  alias Melo.Elo
  use Melo.Web, :controller

  def index(conn, %{"year" => year}) do
    {year, _} = Integer.parse(year)
    ratings = Elo.season(year)

    render(conn, "index.json", ratings: ratings)
  end
end
