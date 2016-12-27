defmodule Melo.StandingsView do
  alias Melo.TeamSeasonView
  use Melo.Web, :view

  def render("index.json", %{standings: standings}) do
    render_many(standings, Melo.StandingsView, "show.json")
  end

  def render("show.json", %{standings: standings}) do
    %{title: standings.title,
      standings: Enum.map(standings.standings, fn data ->
        %{team: TeamSeasonView.render(
            "team_season.json", team_season: data.team_season),
          games_played: data.games_played,
          points: data.points,
          wins: data.wins,
          losses: data.losses,
          draws: data.draws,
          goals_for: data.goals_for,
          goals_against: data.goals_against,
          home_wins: data.home_wins,
          home_losses: data.home_losses,
          home_draws: data.home_draws,
          away_wins: data.away_wins,
          away_losses: data.away_losses,
          away_draws: data.away_draws}
      end)}
  end
end
