# Melo

To create the database and load match data from the seed file:

```
mix ecto.drop
mix ecto.create
mix ecto.migrate
mix run priv/repo/seeds.exs
```

To start the app:
```
mix phoenix.server
```

To regenerate the seed file with all match data from mlssoccer.com:

```
MELO_REGENERATE_SEED=1 mix run priv/repo/seeds.exs
```
