defmodule Melo.Venue do
  use Melo.Web, :model

  schema "venues" do
    field :name, :string
    field :location, :string

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
