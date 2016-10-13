defmodule Melo.Team do
  use Melo.Web, :model

  schema "teams" do
    field :name, :string
    field :location, :string
    has_many :home_matches, Melo.Match, foreign_key: :home_id
    has_many :away_matches, Melo.Match, foreign_key: :away_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :location])
    |> validate_required([:name, :location])
  end
end
