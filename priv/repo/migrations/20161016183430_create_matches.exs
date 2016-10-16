defmodule Melo.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :home_score, :integer, null: false
      add :away_score, :integer, null: false
      add :date, :date, null: false
      add :home_id, references(:team_seasons, on_delete: :nothing, type: :binary_id)
      add :away_id, references(:team_seasons, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:matches, [:home_id])
    create index(:matches, [:away_id])
    create index(:matches, [:date])
  end
end
