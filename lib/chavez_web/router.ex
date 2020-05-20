defmodule ChavezWeb.Router do
  use ChavezWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {ChavezWeb.LayoutView, :root}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChavezWeb do
    pipe_through :browser

    live "/", GameLive
    live "/leaderboard", LeaderboardLive
  end

  # TODO: Secure this in prod
  scope "/" do
    pipe_through :browser
    live_dashboard "/dashboard", metrics: ChavezWeb.Telemetry
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChavezWeb do
  #   pipe_through :api
  # end
end
