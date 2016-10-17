defmodule Melo.StatusController do
  use Melo.Web, :controller

  def index(conn, _params) do
    json conn, %{status: "ok"}
  end
end
