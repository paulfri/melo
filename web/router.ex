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
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", Melo do
    pipe_through :api

    resources "/matches", MatchController, except: [:new, :edit]
    resources "/teams", TeamController, except: [:new, :edit]
    resources "/venues", VenueController, except: [:new, :edit]
  end
end
