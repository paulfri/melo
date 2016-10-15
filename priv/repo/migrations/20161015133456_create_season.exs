defmodule Melo.Repo.Migrations.CreateSeason do
  use Ecto.Migration

  def change do
    create table(:seasons, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :year, :integer

      timestamps()
    end

    create index(:seasons, [:year], unique: true)
  end
end
