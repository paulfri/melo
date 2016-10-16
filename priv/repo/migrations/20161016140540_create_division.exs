defmodule Melo.Repo.Migrations.CreateDivision do
  use Ecto.Migration

  def change do
    create table(:divisions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :season_id, references(:seasons, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:divisions, [:season_id])
  end
end
