defmodule Melo.Seed do
  def run do
    Melo.Seed.Teams.run
    Melo.Seed.Seasons.run
    Melo.Seed.Divisions.run
    Melo.Seed.TeamSeasons.run
    Melo.Seed.Matches.run
  end

  defmodule Teams do
    def run do
      [
        %{abbreviation: "ATL", name: "Atlanta United FC", location: "Atlanta, GA"},
        %{abbreviation: "CHI", name: "Chicago Fire", location: "Bridgeview, IL"},
        %{abbreviation: "CHV", name: "CD Chivas USA", location: "Carson, CA"},
        %{abbreviation: "CLB", name: "Columbus Crew SC", location: "Columbus, OH"},
        %{abbreviation: "COL", name: "Colorado Rapids", location: "Commerce City, CO"},
        %{abbreviation: "DCU", name: "D.C. United", location: "Washington, DC"},
        %{abbreviation: "FCD", name: "FC Dallas", location: "Frisco, TX"},
        %{abbreviation: "HOU", name: "Houston Dynamo", location: "Houston, TX"},
        %{abbreviation: "LAG", name: "LA Galaxy", location: "Carson, CA"},
        %{abbreviation: "LFC", name: "Los Angeles FC", location: "Los Angeles, CA"},
        %{abbreviation: "MIA", name: "Miami Fusion", location: "Miami, FL"},
        %{abbreviation: "MIN", name: "Minnesota United FC", location: "Minneapolis, MN"},
        %{abbreviation: "MTL", name: "Montreal Impact", location: "Montreal, QC, CA"},
        %{abbreviation: "NER", name: "New England Revolution", location: "Foxborough, MA"},
        %{abbreviation: "NYC", name: "New York City FC", location: "New York, NY"},
        %{abbreviation: "NYR", name: "New York Red Bulls", location: "Harrison, NJ"},
        %{abbreviation: "ORL", name: "Orlando City SC", location: "Orlando, FL"},
        %{abbreviation: "PHI", name: "Philadelphia Union", location: "Chester, PA"},
        %{abbreviation: "POR", name: "Portland Timbers", location: "Portland, OR"},
        %{abbreviation: "RSL", name: "Real Salt Lake", location: "Sandy, UT"},
        %{abbreviation: "SEA", name: "Seattle Sounders FC", location: "Seattle, WA"},
        %{abbreviation: "SJE", name: "San Jose Earthquakes", location: "San Jose, CA"},
        %{abbreviation: "SKC", name: "Sporting Kansas City", location: "Kansas City, KC"},
        %{abbreviation: "TBM", name: "Tampa Bay Mutiny", location: "Tampa Bay, FL"},
        %{abbreviation: "TOR", name: "Toronto FC", location: "Toronto, ON, CA"},
        %{abbreviation: "VAN", name: "Vancouver Whitecaps FC", location: "Vancouver, BC, CA"}
      ]
      |> Enum.map(fn(team) ->
        Melo.Repo.insert!(%Melo.Team{
          abbreviation: team.abbreviation,
          name: team.name,
          location: team.location
        })
      end)
    end
  end

  defmodule Seasons do
    def run do
      1996..2015
      |> Enum.map(fn(year) ->
        Melo.Season.changeset(%Melo.Season{}, %{year: year})
      end)
      |> Enum.reduce(Ecto.Multi.new, fn(changeset, multi) ->
        Ecto.Multi.insert(multi, changeset.changes.year, changeset)
      end)
      |> Melo.Repo.transaction
    end
  end

  defmodule Divisions do
    def run do
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
    end
  end

  defmodule TeamSeasons do
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

      Kernel.apply(Melo.Seed.TeamSeasons, String.to_atom("east_#{year}"), [])
      |> Enum.each(fn(abbr) ->
        insert(%{
          team: team(abbr),
          division: east
        })
      end)

      Kernel.apply(Melo.Seed.TeamSeasons, String.to_atom("cent_#{year}"), [])
      |> Enum.each(fn(abbr) ->
        insert(%{
          team: team(abbr),
          division: cent
        })
      end)

      Kernel.apply(Melo.Seed.TeamSeasons, String.to_atom("west_#{year}"), [])
      |> Enum.each(fn(abbr) ->
        insert(%{
          team: team(abbr),
          division: west
        })
      end)
    end
  end

  defmodule Matches do
    def run do
      Mix.Tasks.Import.run(nil)
    end
  end
end
