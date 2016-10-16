defmodule Melo.MatchView do
  use Melo.Web, :view

  def render("index.json", %{matches: matches}) do
    %{matches: render_many(matches, Melo.MatchView, "match.json")}
  end

  def render("show.json", %{match: match}) do
    %{match: render_one(match, Melo.MatchView, "match.json")}
  end

  def render("match.json", %{match: match}) do
    %{id: match.id,
      home: match.home.team.name,
      away: match.away.team.name,
      home_score: match.home_score,
      away_score: match.away_score,
      date: match.date}
  end
end
