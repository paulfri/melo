defmodule Melo.TeamController do
  use Melo.Web, :controller

  alias Melo.Team

  def index(conn, _params) do
    teams = Repo.all(Team)
    render(conn, "index.json", teams: teams)
  end

  def show(conn, %{"id" => abbrev}) do
    team = Repo.get_by!(Team, abbreviation: abbrev)

    render(conn, "show.json", team: team)
  end
end
