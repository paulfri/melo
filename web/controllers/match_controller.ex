defmodule Melo.MatchController do
  use Melo.Web, :controller

  alias Melo.Match

  def index(conn, params) do
    query = from(m in Match, preload: [:home, :away])

    query = filter_date(query, {
      Map.get(params, "year"),
      Map.get(params, "month"),
      Map.get(params, "day")
    })

    query = filter_team(query, Map.get(params, "team"))
    query = filter_home(query, Map.get(params, "home"))
    query = filter_away(query, Map.get(params, "away"))

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
        {String.to_integer(year), String.to_integer(month), String.to_integer(day)}
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
    start_date = Ecto.Date.from_erl({year, 1, 1})
    end_date   = Ecto.Date.from_erl({year + 1, 1, 1})

    query
    |> apply_date_filter(start_date, end_date)
  end

  defp filter_date(query, year, month, nil) do
    start_date = Ecto.Date.from_erl({year, month, 1})
    end_date   = Ecto.Date.from_erl({year, month + 1, 1})

    query
    |> apply_date_filter(start_date, end_date)
  end

  defp filter_date(query, year, month, day) do
    start_date = Ecto.Date.from_erl({year, month, day})
    end_date   = Ecto.Date.from_erl({year, month, day + 1})

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
    |> join(:inner, [m], home in assoc(m, :home))
    |> join(:inner, [m], away in assoc(m, :away))
    |> where([_, home, away], home.abbreviation == ^team or away.abbreviation == ^team)
  end
end
