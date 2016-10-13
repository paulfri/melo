defmodule Melo.TeamView do
  use Melo.Web, :view

  def render("index.json", %{teams: teams}) do
    %{data: render_many(teams, Melo.TeamView, "team.json")}
  end

  def render("show.json", %{team: team}) do
    %{data: render_one(team, Melo.TeamView, "team.json")}
  end

  def render("team.json", %{team: team}) do
    %{id: team.id,
      name: team.name,
      location: team.location}
  end
end
