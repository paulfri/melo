defmodule Melo.TeamSeasonView do
  alias Melo.TeamSeason
  use Melo.Web, :view

  def render("team_season.json", %{team_season: team_season}) do
    %{
      name: TeamSeason.name(team_season),
      abbreviation: TeamSeason.abbreviation(team_season)
    }
  end
end
