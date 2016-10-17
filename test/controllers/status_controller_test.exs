defmodule Melo.StatusControllerTest do
  use Melo.ConnCase

  test "GET /status", %{conn: conn} do
    conn = get conn, "/status"

    assert json_response(conn, 200)["status"] == "ok"
  end
end
