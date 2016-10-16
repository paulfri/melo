defmodule Melo.Team do
  use Melo.Web, :model

  schema "teams" do
    field :name, :string
    field :location, :string
    field :abbreviation, :string
    has_many :home_matches, Melo.Match, foreign_key: :home_id
    has_many :away_matches, Melo.Match, foreign_key: :away_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :location, :abbreviation])
    |> unique_constraint(:name)
    |> unique_constraint(:abbreviation)
    |> validate_required([:name, :location, :abbreviation])
    |> validate_length(:abbreviation, is: 3)
  end
end
