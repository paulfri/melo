defmodule Melo.TeamControllerTest do
  use Melo.ConnCase

  alias Melo.Team
  @valid_attrs %{location: "some content", name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, team_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    team = Repo.insert! %Team{}
    conn = get conn, team_path(conn, :show, team)
    assert json_response(conn, 200)["data"] == %{"id" => team.id,
      "name" => team.name,
      "location" => team.location}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, team_path(conn, :show, "11111111-1111-1111-1111-111111111111")
    end
  end
end
