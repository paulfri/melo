defmodule Melo.EloView do
  alias Melo.TeamSeasonView
  use Melo.Web, :view

  def render("index.json", %{ratings: ratings}) do
    Enum.map(ratings, fn %{rating: rating, team_season: ts} ->
      %{team: TeamSeasonView.render("team_season.json", team_season: ts),
        rating: rating}
    end)
  end
end
