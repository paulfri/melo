# Imports seed data from Postgres dump file. If the MELO_REGENERATE_SEED
# environment variable is present, it will re-scrape mlssoccer.com for match
# data and regenerate the seeds.sql file.

seed_file = Application.app_dir(:melo, "priv/repo/seeds.sql")

###
if System.get_env("MELO_REGENERATE_SEED") do
  Melo.Seed.run

  Mix.shell.cmd("pg_dump --column-inserts --exclude-table=schema_migrations \
    --data-only melo_#{Mix.env} > #{seed_file}")
else
  Mix.shell.cmd("psql --dbname=melo_#{Mix.env} --file=#{seed_file} \
    > /dev/null 2>&1")
end
