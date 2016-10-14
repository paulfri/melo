defmodule Melo.MatchController do
  use Melo.Web, :controller

  alias Melo.Match

  def index(conn, params) do
    query = from(m in Match, preload: [:home, :away, :venue])

    query = filter_date(query, {
      Map.get(params, "year"),
      Map.get(params, "month"),
      Map.get(params, "day")
    })

    render(conn, "index.json", matches: Repo.all(query))
  end

  def create(conn, %{"match" => match_params}) do
    changeset = Match.changeset(%Match{}, match_params)

    case Repo.insert(changeset) do
      {:ok, match} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", match_path(conn, :show, match))
        |> render("show.json", match: match)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Melo.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    match = Repo.get!(Match, id)
    render(conn, "show.json", match: match)
  end

  def update(conn, %{"id" => id, "match" => match_params}) do
    match = Repo.get!(Match, id)
    changeset = Match.changeset(match, match_params)

    case Repo.update(changeset) do
      {:ok, match} ->
        render(conn, "show.json", match: match)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Melo.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    match = Repo.get!(Match, id)

    Repo.delete!(match)

    send_resp(conn, :no_content, "")
  end

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
end
