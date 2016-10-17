# Scrapes MLS match results by year from mlssoccer.com and serializes to CSV.
defmodule Melo.Scraper do
  def scrape(year) do
    year
    |> build_url
    |> HTTPoison.get!([], [timeout: :infinity, recv_timeout: :infinity])
    |> get_fixtures
    |> parse_games
  end

  def build_url(year) do
    "http://www.mlssoccer.com/schedule?month=all&year=#{year}&club_options=9"
  end

  defp get_fixtures(response) do
    Floki.find(response.body, "ul.schedule_list li.row")
  end

  defp parse_games(games, old_date \\ nil, acc \\ [])
  defp parse_games([], _old_date, acc), do: Enum.reverse(acc)
  defp parse_games([game | rest], old_date, acc) do
    new_date = text(game, ".match_date")

    if is_nil(new_date) do
      parse_games(rest, old_date, [to_csv(game, old_date) | acc])
    else
      new_date = new_date
                 |> Timex.parse!("%A, %B %e, %Y", :strftime)
                 |> Timex.format!("{YYYY}-{0M}-{0D}")

      parse_games(rest, new_date, [to_csv(game, new_date) | acc])
    end
  end

  defp to_csv(game, date) do
    home       = game |> text(".home_club .club_name")
    home_score = game |> text(".home_club .match_score") |> String.to_integer
    away       = game |> text(".vs_club   .club_name")
    away_score = game |> text(".vs_club   .match_score") |> String.to_integer
    [_, venue] = game
                 |> text(".match_location_competition")
                 |> String.split(" / ")

    %{home: home,
      away: away,
      home_score: home_score,
      away_score: away_score,
      date: date,
      venue: venue}
  end

  defp text(content, selector) do
    case content |> Floki.find(selector) |> Floki.text do
      ""       -> nil
      presence -> presence
    end
  end
end
