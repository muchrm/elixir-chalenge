defmodule ChalengeWeb.Router do
  use ChalengeWeb, :router

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

  scope "/", ChalengeWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/list", PageController, :listGithub
  end

  # Other scopes may use custom stacks.
  scope "/part1", ChalengeWeb do
    pipe_through :api
    post "/", PageController, :reOrder
  end
end
