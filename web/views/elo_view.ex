defmodule Melo.EloView do
  use Melo.Web, :view

  def render("index.json", %{ratings: ratings}) do
    Enum.map(ratings, fn %{team: team, rating: rating} ->
      %{team: Melo.TeamView.render("team.json", team: team),
        rating: rating}
    end)
  end
end
