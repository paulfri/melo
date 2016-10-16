defmodule Melo.Division do
  use Melo.Web, :model

  schema "divisions" do
    field :name, :string
    belongs_to :season, Melo.Season

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> put_assoc(:season, params[:season])
  end
end
