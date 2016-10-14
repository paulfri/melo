defmodule Melo.Repo.Migrations.CreateTeamsAndMatches do
  use Ecto.Migration

  def change do
    create table(:teams, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :location, :string, null: false
      add :abbreviation, :string, null: false
      add :year_start, :integer, null: false
      add :year_end, :integer

      timestamps()
    end

    create table(:matches, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :home_score, :integer, null: false
      add :away_score, :integer, null: false
      add :date, :date, null: false
      add :home_id, references(:teams, on_delete: :nothing, type: :binary_id)
      add :away_id, references(:teams, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:matches, [:home_id])
    create index(:matches, [:away_id])
    create index(:matches, [:date])

    create index(:teams, [:name], unique: true)
    create index(:teams, [:abbreviation], unique: true)
    create constraint(:teams, :abbreviation_lte_3,
                      check: "char_length(abbreviation) <= 3")
  end
end
