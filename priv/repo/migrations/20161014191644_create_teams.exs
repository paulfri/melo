defmodule Melo.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :location, :string, null: false
      add :abbreviation, :string, null: false

      timestamps()
    end

    create index(:teams, [:name], unique: true)
    create index(:teams, [:abbreviation], unique: true)
    create constraint(:teams, :abbreviation_lte_3,
                      check: "char_length(abbreviation) <= 3")
  end
end
