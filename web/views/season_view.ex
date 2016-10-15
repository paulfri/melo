defmodule Melo.SeasonView do
  use Melo.Web, :view

  def render("index.json", %{seasons: seasons}) do
    %{data: render_many(seasons, Melo.SeasonView, "season.json")}
  end

  def render("show.json", %{season: season}) do
    %{data: render_one(season, Melo.SeasonView, "season.json")}
  end

  def render("season.json", %{season: season}) do
    %{id: season.id,
      year: season.year}
  end
end
