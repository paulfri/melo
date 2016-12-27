defmodule Melo.TeamSeason do
  use Melo.Web, :model

  schema "team_seasons" do
    field :alias, :string
    field :alias_abbreviation, :string
    belongs_to :team, Melo.Team
    belongs_to :division, Melo.Division

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:alias, :alias_abbreviation])
    |> put_assoc(:team, params[:team])
    |> put_assoc(:division, params[:division])
  end

  def name(team_season) do
    team_season.alias || team_season.team.name
  end

  def abbreviation(team_season) do
    team_season.alias_abbreviation || team_season.team.abbreviation
  end

  @doc """
  Returns all the TeamSeasons for a given season.
  """
  @lint {Credo.Check.Refactor.PipeChainStart, false}
  def season(year) do
    Repo.all(
      from ts in Melo.TeamSeason,
      join: d in Melo.Division, where: ts.division_id == d.id,
      join: s in Melo.Season, where: s.id == d.season_id,
      join: t in Melo.Team, where: ts.team_id == t.id,
      where: s.year == ^year,
      select: ts
    )
    |> Repo.preload(:team)
    |> Repo.preload(:division)
  end
end
