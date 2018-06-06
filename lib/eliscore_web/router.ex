defmodule EliscoreWeb.Router do
  use EliscoreWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authorized do
    plug :accepts, ["json"]
    plug CORSPlug
    plug Eliscore.Guardian.AuthPipeline
  end

  pipeline :unauthorized do
    plug :accepts, ["json"]
    plug CORSPlug
    plug Guardian.Plug.Pipeline, otp_app: :eliscore,
      module: Eliscore.Guardian,
      error_handler: Eliscore.Guardian.AuthErrorHandler
  end

  scope "/api", EliscoreWeb do
    pipe_through :unauthorized

    scope "/v1" do
      post "/registrations", RegistrationController, :create
      get "/verify_token", TokensController, :verify
    end
  end

  scope path: "/api" do
    pipe_through :authorized

    scope "/v1" do
      get "/channel", ChannelsController, :index
    end

    forward "/", EliscoreWeb.API.Core
  end

  scope "/", EliscoreWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/*path", PageController, :index
  end
end
