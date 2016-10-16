defmodule Melo.Season do
  use Melo.Web, :model

  schema "seasons" do
    field :year, :integer
    has_many :divisions, Melo.Division

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:year])
    |> validate_required([:year])
  end
end
