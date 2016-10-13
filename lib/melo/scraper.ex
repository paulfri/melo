# Scrapes MLS match results by year from mlssoccer.com and serializes to CSV.
defmodule Melo.Scraper do
  def scrape(year) do
    build_url(year)
    |> HTTPoison.get!([], [timeout: :infinity, recv_timeout: :infinity])
    |> get_fixtures
    |> parse_games
    |> Enum.join("\n")
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
      new_date = Timex.parse!(new_date, "%A, %B %e, %Y", :strftime)
        |> Timex.format!("{YYYY}-{0M}-{0D}")

      parse_games(rest, new_date, [to_csv(game, new_date) | acc])
    end
  end

  defp to_csv(game_div, date) do
    home       = game_div |> text(".home_club .club_name")
    home_score = game_div |> text(".home_club .match_score")
    away       = game_div |> text(".vs_club   .club_name")
    away_score = game_div |> text(".vs_club   .match_score")
    [_, venue] = game_div
      |> text(".match_location_competition")
      |> String.split(" / ")

    "#{date},#{home},#{home_score},#{away},#{away_score},#{venue}"
  end

  defp text(content, selector) do
    case Floki.find(content, selector) |> Floki.text do
      ""       -> nil
      presence -> presence
    end
  end
end
