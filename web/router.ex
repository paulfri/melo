defmodule Melo.Router do
  use Melo.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Melo do
    pipe_through :api

    get "/status", StatusController, :index
  end

  scope "/", Melo do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", Melo do
    pipe_through :api

    resources "/matches", MatchController, only: [:index, :show]
    resources "/teams", TeamController, only: [:index, :show]
    resources "/seasons", SeasonController, only: [:index, :show]
  end
end
