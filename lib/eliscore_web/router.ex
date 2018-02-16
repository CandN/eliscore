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
    plug Guardian.Plug.Pipeline, otp_app: :eliscore,
      module: Eliscore.Guardian,
      error_handler: Eliscore.Guardian.AuthErrorHandler
  end

  scope "/api", EliscoreWeb do
    pipe_through :unauthorized

    scope "/v1" do
      post "/registrations", RegistrationController, :create
    end
  end

  scope "/api", EliscoreWeb do
    pipe_through :authorized

    scope "/v1" do
      post "/sessions", SessionController, :create
      delete "/sessions", SessionController, :delete

      get "/current_user", CurrentUserController, :show

      get "/matches", MatchController, :index
      post "/matches", MatchController, :create
      options "/matches", MatchController, :nothing

      get "/leaderboard", LeaderboardController, :index

      resources "/users", UserController, only: [:index, :show]
      resources "/categories", CategoryController, only: [:index]
    end
  end

  scope "/", EliscoreWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/*path", PageController, :index
  end
end
