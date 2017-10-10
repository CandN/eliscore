defmodule EliscoreWeb.UsersController do
  use EliscoreWeb, :controller

  alias Eliscore.{ User, Repo }
  
  def index(conn, _params) do
    users = Repo.all(User)

    conn
    |> put_status(:ok)
    |> render("index.json", users: users)
  end
  
  def show(conn, params) do
    case Repo.get_by(User, login: params["username"]) do
      nil ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json")
      user ->
        conn
        |> put_status(:ok)
        |> render("show.jsonname", user: user)
    end
  end
end
