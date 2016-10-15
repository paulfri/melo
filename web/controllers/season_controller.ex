defmodule Melo.SeasonController do
  use Melo.Web, :controller

  alias Melo.Season

  def index(conn, _params) do
    seasons = Repo.all(Season)
    render(conn, "index.json", seasons: seasons)
  end

  def show(conn, %{"id" => id}) do
    season = Repo.get!(Season, id)
    render(conn, "show.json", season: season)
  end
end
