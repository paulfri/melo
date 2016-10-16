# Imports seed data from Postgres dump file. To regenerate seed data:
#
# ```
# pg_dump --column-inserts --exclude-table=schema_migrations --data-only \
#   melo_dev > priv/repo/seeds.sql
# ```

file = Application.app_dir(:melo, "priv/repo/seeds.sql")

Mix.shell.cmd("psql --dbname=melo_#{Mix.env} --file=#{file}")

#

(1996..2015)
|> Enum.map(fn(year) ->
  Melo.Season.changeset(%Melo.Season{}, %{year: year})
end)
|> Enum.reduce(Ecto.Multi.new, fn(changeset, multi) ->
  Ecto.Multi.insert(multi, changeset.changes.year, changeset)
end)
|> Melo.Repo.transaction

seasons = Melo.Repo.all(Melo.Season)

1996..2015
|> Enum.map(fn(year) ->
  season = Melo.Repo.get_by!(Melo.Season, year: year)

  cond do
    year == 2000 || year == 2001 ->
      [Melo.Division.changeset(%Melo.Division{}, %{
        season: season,
        name: "Eastern Division"
      }),
      Melo.Division.changeset(%Melo.Division{}, %{
        season: season,
        name: "Central Division"
      }),
      Melo.Division.changeset(%Melo.Division{}, %{
        season: season,
        name: "Western Division"
      })]
    true ->
      [Melo.Division.changeset(%Melo.Division{}, %{
        season: season,
        name: "Eastern Conference"
      }),
      Melo.Division.changeset(%Melo.Division{}, %{
        season: season,
        name: "Western Conference"
      })]
  end
end)
|> List.flatten
|> Enum.reduce(Ecto.Multi.new, fn(changeset, multi) ->
  insert_name = "#{changeset.changes.season.data.year}_#{changeset.changes.name}"
                |> String.replace(" ", "")
                |> Macro.underscore

  Ecto.Multi.insert(multi, String.to_atom(insert_name), changeset)
end)
|> Melo.Repo.transaction
