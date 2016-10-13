defmodule Melo.Repo.Migrations.CreateVenue do
  use Ecto.Migration

  def change do
    create table(:venues, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :location, :string, null: false

      timestamps()
    end

  end
end
