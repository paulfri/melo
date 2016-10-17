defmodule Melo.MatchControllerTest do
  use Melo.ConnCase

  alias Melo.Match
  @valid_attrs %{away_score: 42, date: %{day: 17, month: 4, year: 2010}, home_score: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, match_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    match = Repo.insert! %Match{}
    conn = get conn, match_path(conn, :show, match)
    assert json_response(conn, 200)["data"] == %{"id" => match.id,
      "home" => match.home,
      "away" => match.away,
      "home_score" => match.home_score,
      "away_score" => match.away_score,
      "date" => match.date}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, match_path(conn, :show, "11111111-1111-1111-1111-111111111111")
    end
  end
end
