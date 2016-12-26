defmodule Melo.EloView do
  use Melo.Web, :view

  def render("index.json", %{ratings: ratings}) do
    Enum.map(ratings, fn %{team: team, rating: rating, team_season: ts} ->
      %{team: Melo.TeamSeasonView.render("team_season.json", team_season: ts),
        rating: rating}
    end)
  end
end
