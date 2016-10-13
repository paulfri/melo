defmodule Melo.PageController do
  use Melo.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
