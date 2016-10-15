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
