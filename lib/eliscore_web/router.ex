defmodule EliscoreWeb.Router do
  use EliscoreWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  scope "/api", EliscoreWeb do
    pipe_through :api

    scope "/v1" do
      post "/registrations", RegistrationController, :create

      post "/sessions", SessionController, :create
      delete "/sessions", SessionController, :delete

      get "/current_user", CurrentUserController, :show

      get "/matches", MatchController, :index
      post "/matches", MatchController, :create
      options "/matches", MatchController, :nothing

      resources "/users", UserController, only: [:index, :show]
    end
  end

  scope "/auth", EliscoreWeb do
    pipe_through :browser

    get "/:provider", RegistrationController, :request
    get "/:provider/callback", RegistrationController, :callback
  end

  scope "/", EliscoreWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/*path", PageController, :index
  end


  # Other scopes may use custom stacks.
  # scope "/api", EliscoreWeb do
  #   pipe_through :api
  # end
end
