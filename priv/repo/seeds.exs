# Imports seed data from Postgres dump file. To regenerate seed data:
#
# ```
# pg_dump --column-inserts --exclude-table=schema_migrations --data-only \
#   melo_dev > priv/repo/seeds.sql
# ```

file = Application.app_dir(:melo, "priv/repo/seeds.sql")

Mix.shell.cmd("psql --dbname=melo_#{Mix.env} --file=#{file}")

###

defmodule Melo.Seed do
  def east_1996(), do: ["CLB", "DCU", "NER", "NYR", "TBM"]
  def cent_1996(), do: []
  def west_1996(), do: ["COL", "FCD", "SKC", "LAG", "SJE"]

  def east_1997(), do: ["CLB", "DCU", "NER", "NYR", "TBM"]
  def cent_1997(), do: []
  def west_1997(), do: ["COL", "FCD", "SKC", "LAG", "SJE"]

  def east_1998(), do: ["CLB", "DCU", "MIA", "NER", "NYR", "TBM"]
  def cent_1998(), do: []
  def west_1998(), do: ["CHI", "COL", "FCD", "SKC", "LAG", "SJE"]

  def east_1999(), do: ["CLB", "DCU", "MIA", "NER", "NYR", "TBM"]
  def cent_1999(), do: []
  def west_1999(), do: ["CHI", "COL", "FCD", "SKC", "LAG", "SJE"]

  def east_2000(), do: ["DCU", "MIA", "NER", "NYR"]
  def cent_2000(), do: ["CHI", "CLB", "FCD", "TBM"]
  def west_2000(), do: ["COL", "LAG", "SJE", "SKC"]

  def east_2001(), do: ["DCU", "MIA", "NER", "NYR"]
  def cent_2001(), do: ["CHI", "CLB", "FCD", "TBM"]
  def west_2001(), do: ["COL", "LAG", "SJE", "SKC"]

  def east_2002(), do: ["CHI", "CLB", "DCU", "NER", "NYR"]
  def cent_2002(), do: []
  def west_2002(), do: ["COL", "FCD", "LAG", "SJE", "SKC"]

  def east_2003(), do: ["CHI", "CLB", "DCU", "NER", "NYR"]
  def cent_2003(), do: []
  def west_2003(), do: ["COL", "FCD", "LAG", "SJE", "SKC"]

  def east_2004(), do: ["CHI", "CLB", "DCU", "NER", "NYR"]
  def cent_2004(), do: []
  def west_2004(), do: ["COL", "FCD", "LAG", "SJE", "SKC"]

  def east_2005(), do: ["CHI", "CLB", "DCU", "NER", "NYR", "SKC"]
  def cent_2005(), do: []
  def west_2005(), do: ["CHV", "COL", "FCD", "LAG", "RSL", "SJE"]

  def east_2006(), do: ["CHI", "CLB", "DCU", "NER", "NYR", "SKC"]
  def cent_2006(), do: []
  def west_2006(), do: ["CHV", "COL", "FCD", "HOU", "LAG", "RSL"]

  def east_2007(), do: ["CHI", "CLB", "DCU", "NER", "NYR", "SKC", "TOR"]
  def cent_2007(), do: []
  def west_2007(), do: ["CHV", "COL", "FCD", "HOU", "LAG", "RSL"]

  def east_2008(), do: ["CHI", "CLB", "DCU", "NER", "NYR", "SKC", "TOR"]
  def cent_2008(), do: []
  def west_2008(), do: ["CHV", "COL", "FCD", "HOU", "LAG", "RSL", "SJE"]

  def east_2009(), do: ["CHI", "CLB", "DCU", "NER", "NYR", "SKC", "TOR"]
  def cent_2009(), do: []
  def west_2009(), do: ["CHV", "COL", "FCD", "HOU", "LAG", "RSL", "SEA", "SJE"]

  def east_2010(), do: ["CHI", "CLB", "DCU", "NER", "NYR", "PHI", "SKC", "TOR"]
  def cent_2010(), do: []
  def west_2010(), do: ["CHV", "COL", "FCD", "HOU", "LAG", "RSL", "SEA", "SJE"]

  def east_2011(), do: ["CHI", "CLB", "DCU", "HOU", "NER", "NYR", "PHI", "SKC", "TOR"]
  def cent_2011(), do: []
  def west_2011(), do: ["CHV", "COL", "FCD", "LAG", "POR", "RSL", "SEA", "SJE", "VAN"]

  def east_2012(), do: ["CHI", "CLB", "DCU", "HOU", "MTL", "NER", "NYR", "PHI", "SKC", "TOR"]
  def cent_2012(), do: []
  def west_2012(), do: ["CHV", "COL", "FCD", "LAG", "POR", "RSL", "SEA", "SJE", "VAN"]

  def east_2013(), do: ["CHI", "CLB", "DCU", "HOU", "MTL", "NER", "NYR", "PHI", "SKC", "TOR"]
  def cent_2013(), do: []
  def west_2013(), do: ["CHV", "COL", "FCD", "LAG", "POR", "RSL", "SEA", "SJE", "VAN"]

  def east_2014(), do: ["CHI", "CLB", "DCU", "HOU", "MTL", "NER", "NYR", "PHI", "SKC", "TOR"]
  def cent_2014(), do: []
  def west_2014(), do: ["CHV", "COL", "FCD", "LAG", "POR", "RSL", "SEA", "SJE", "VAN"]

  def east_2015(), do: ["CHI", "CLB", "DCU", "MTL", "NER", "NYC", "NYR", "ORL", "PHI", "TOR"]
  def cent_2015(), do: []
  def west_2015(), do: ["COL", "FCD", "HOU", "LAG", "POR", "RSL", "SEA", "SJE", "SKC", "VAN"]

  def east_2016(), do: ["CHI", "CLB", "DCU", "MTL", "NER", "NYC", "NYR", "ORL", "PHI", "TOR"]
  def cent_2016(), do: []
  def west_2016(), do: ["COL", "FCD", "HOU", "LAG", "POR", "RSL", "SEA", "SJE", "SKC", "VAN"]

  def east_2017(), do: ["ATL", "CHI", "CLB", "DCU", "MTL", "NER", "NYC", "NYR", "ORL", "PHI", "TOR"]
  def cent_2017(), do: []
  def west_2017(), do: ["COL", "FCD", "HOU", "LAG", "MIN", "POR", "RSL", "SEA", "SJE", "SKC", "VAN"]

  def team(abbr) do
    Melo.Repo.get_by!(Melo.Team, abbreviation: abbr)
  end

  def season(year) do
    Melo.Repo.get_by!(Melo.Season, year: year)
  end

  def division(name, season) do
    Melo.Repo.get_by!(Melo.Division, name: name, season_id: season.id)
  end

  def insert(team_season) do
    Melo.Repo.insert!(Melo.TeamSeason.changeset(%Melo.TeamSeason{}, team_season))
  end

  def run do
    1996..2015 |> Enum.each(&(run_year(&1)))
  end

  def run_year(year) do
    s = season(year)

    {east, cent, west} = if year == 2000 || year == 2001 do
        {division("Eastern Division", s),
         division("Central Division", s),
         division("Western Division", s)}
    else
        {division("Eastern Conference", s),
         nil,
         division("Western Conference", s)}
    end

    Kernel.apply(Melo.Seed, String.to_atom("east_#{year}"), [])
    |> Enum.each(fn(abbr) ->
      insert(%{
        team: team(abbr),
        division: east
      })
    end)

    Kernel.apply(Melo.Seed, String.to_atom("cent_#{year}"), [])
    |> Enum.each(fn(abbr) ->
      insert(%{
        team: team(abbr),
        division: cent
      })
    end)

    Kernel.apply(Melo.Seed, String.to_atom("west_#{year}"), [])
    |> Enum.each(fn(abbr) ->
      insert(%{
        team: team(abbr),
        division: west
      })
    end)
  end
end

Melo.Seed.run
