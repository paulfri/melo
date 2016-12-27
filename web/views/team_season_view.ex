defmodule Melo.TeamSeasonView do
  use Melo.Web, :view

  def render("team_season.json", %{team_season: team_season}) do
    %{
      name: Melo.TeamSeason.name(team_season),
      abbreviation: Melo.TeamSeason.abbreviation(team_season)
    }
  end
end
