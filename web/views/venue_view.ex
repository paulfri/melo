defmodule Melo.VenueView do
  use Melo.Web, :view

  def render("index.json", %{venues: venues}) do
    %{data: render_many(venues, Melo.VenueView, "venue.json")}
  end

  def render("show.json", %{venue: venue}) do
    %{data: render_one(venue, Melo.VenueView, "venue.json")}
  end

  def render("venue.json", %{venue: venue}) do
    %{id: venue.id,
      name: venue.name,
      location: venue.location}
  end
end
