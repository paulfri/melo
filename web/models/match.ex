defmodule Melo.Match do
  use Melo.Web, :model
  alias Ecto.Date

  schema "matches" do
    field :home_score, :integer
    field :away_score, :integer
    field :date, Ecto.Date
    belongs_to :home, Melo.TeamSeason
    belongs_to :away, Melo.TeamSeason

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:home_score, :away_score, :date])
    |> validate_required([:home_score, :away_score, :date])
  end

  @doc """
  Returns all the matches in a given season.
  """
  @lint {Credo.Check.Refactor.PipeChainStart, false}
  def season(year) do
    start_date = Date.from_erl({year, 1, 1})
    end_date = Date.from_erl({year + 1, 1, 1})

    Repo.all(
      from m in Melo.Match,
      where: m.date >= ^start_date,
      where: m.date <  ^end_date
    )
    |> Repo.preload(:home)
    |> Repo.preload(home: :team)
    |> Repo.preload(:away)
    |> Repo.preload(away: :team)
  end
end
