defmodule Melo.Repo.Migrations.CreateMatch do
  use Ecto.Migration

  def change do
    create table(:matches, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :home_score, :integer, null: false
      add :away_score, :integer, null: false
      add :date, :date, null: false
      add :home, references(:teams, on_delete: :nothing, type: :binary_id)
      add :away, references(:teams, on_delete: :nothing, type: :binary_id)
      add :venue, references(:venues, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:matches, [:home])
    create index(:matches, [:away])
    create index(:matches, [:venue])
    create index(:matches, [:date])
  end
end
