defmodule Melo.MatchView do
  alias Melo.TeamSeason
  use Melo.Web, :view

  def render("index.json", %{matches: matches}) do
    %{matches: render_many(matches, Melo.MatchView, "match.json")}
  end

  def render("show.json", %{match: match}) do
    %{match: render_one(match, Melo.MatchView, "match.json")}
  end

  def render("match.json", %{match: match}) do
    %{id: match.id,
      home: TeamSeason.name(match.home),
      away: TeamSeason.name(match.away),
      home_score: match.home_score,
      away_score: match.away_score,
      date: match.date}
  end
end
