# Imports seed data from Postgres dump file.
# To regenerate seed data:
#
# pg_dump --column-inserts --exclude-table=schema_migrations --data-only melo_dev > priv/repo/seeds.sql

file = Application.app_dir(:melo, "priv/repo/seeds.sql")

Mix.shell.cmd("psql --dbname=melo_#{Mix.env} --file=#{file}")
