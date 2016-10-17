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
end
