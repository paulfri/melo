defmodule Melo.Repo.Migrations.CreateTeamSeason do
  use Ecto.Migration

  def change do
    create table(:team_seasons, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :alias, :string
      add :alias_abbreviation, :string
      add :team_id, references(:teams, on_delete: :nothing, type: :binary_id)
      add :division_id, references(:divisions, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:team_seasons, [:team_id])
    create index(:team_seasons, [:division_id])
    create constraint(:team_seasons, :alias_abbreviation_lte_3,
                      check: "char_length(alias_abbreviation) <= 3")
  end
end
