defmodule LiveViewPatchWeb.Router do
  use LiveViewPatchWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_live_layout, {LiveViewPatchWeb.LayoutView, "live.html"}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveViewPatchWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/home", HomeLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveViewPatchWeb do
  #   pipe_through :api
  # end
end
