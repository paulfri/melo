defmodule Melo.SeasonControllerTest do
  use Melo.ConnCase

  alias Melo.Season
  @valid_attrs %{year: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, season_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    season = Repo.insert! %Season{}
    conn = get conn, season_path(conn, :show, season)
    assert json_response(conn, 200)["data"] == %{"id" => season.id,
      "year" => season.year}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, season_path(conn, :show, "11111111-1111-1111-1111-111111111111")
    end
  end
end
