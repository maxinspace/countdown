defmodule CountdownWeb.Router do
  use CountdownWeb, :router

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

  scope "/", CountdownWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/events", EventController

    # auth0
    get "/auth", AuthController, :index
    get "/login", AuthController, :login
    get "/logout", AuthController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", CountdownWeb do
  #   pipe_through :api
  # end
end
