defmodule Melo.Match do
  use Melo.Web, :model

  schema "matches" do
    field :home_score, :integer
    field :away_score, :integer
    field :date, Ecto.Date
    belongs_to :home, Melo.Team
    belongs_to :away, Melo.Team

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
end
