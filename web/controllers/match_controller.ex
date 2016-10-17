defmodule Melo.MatchController do
  use Melo.Web, :controller
  alias Ecto.Date
  alias Melo.Match

  def index(conn, params) do
    query = from(m in Match, preload: [home: :team, away: :team])

    query = filter_date(query, {
      Map.get(params, "year"),
      Map.get(params, "month"),
      Map.get(params, "day")
    })

    query = filter_team(query, Map.get(params, "team"))
    query = filter_home(query, Map.get(params, "home"))
    query = filter_away(query, Map.get(params, "away"))
    query = order(query, Map.get(params, "order", "asc"))

    render(conn, "index.json", matches: Repo.all(query))
  end

  def show(conn, %{"id" => id}) do
    match = Repo.get!(Match, id)
    render(conn, "show.json", match: match)
  end

  ###

  defp filter_date(query, {year, month, day}) do
    {year, month, day} = cond do
      year && month && day ->
        {String.to_integer(year),
         String.to_integer(month),
         String.to_integer(day)}
      year && month ->
        {String.to_integer(year), String.to_integer(month), nil}
      year ->
        {String.to_integer(year), nil, nil}
      true ->
        {nil, nil, nil}
    end

    filter_date(query, year, month, day)
  end

  defp filter_date(query, nil, nil, nil), do: query

  defp filter_date(query, year, nil, nil) do
    start_date = Date.from_erl({year, 1, 1})
    end_date   = Date.from_erl({year + 1, 1, 1})

    query
    |> apply_date_filter(start_date, end_date)
  end

  defp filter_date(query, year, month, nil) do
    start_date = Date.from_erl({year, month, 1})
    end_date   = Date.from_erl({year, month + 1, 1})

    query
    |> apply_date_filter(start_date, end_date)
  end

  defp filter_date(query, year, month, day) do
    start_date = Date.from_erl({year, month, day})
    end_date   = Date.from_erl({year, month, day + 1})

    query
    |> apply_date_filter(start_date, end_date)
  end

  defp apply_date_filter(query, start_date, end_date) do
    query
    |> where([m], m.date >= ^start_date)
    |> where([m], m.date <  ^end_date)
  end

  defp filter_home(query, nil), do: query
  defp filter_home(query, team) do
    query
    |> join(:inner, [m], home in assoc(m, :home))
    |> where([_, home], home.abbreviation == ^String.upcase(team))
  end

  defp filter_away(query, nil), do: query
  defp filter_away(query, team) do
    query
    |> join(:inner, [m], away in assoc(m, :away))
    |> where([_, away], away.abbreviation == ^String.upcase(team))
  end

  defp filter_team(query, nil), do: query
  defp filter_team(query, team) do
    team = String.upcase(team)

    query
    |> join(:inner, [m], home_season in assoc(m, :home))
    |> join(:inner, [m], away_season in assoc(m, :away))
    |> join(:inner, [m, h, _a], home_team in assoc(h, :team))
    |> join(:inner, [m, _h, a], away_team in assoc(a, :team))
    |> where(
         [_, _h, _a, home_team, away_team],
         home_team.abbreviation == ^team or away_team.abbreviation == ^team
       )
  end

  defp order(query, "asc"), do: query |> order_by(asc: :date)
  defp order(query, "desc"), do: query |> order_by(desc: :date)
end
