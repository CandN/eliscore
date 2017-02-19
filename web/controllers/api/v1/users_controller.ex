defmodule Eliscore.UsersController do
  use Eliscore.Web, :controller

  alias Eliscore.User

  def index(conn, _params) do
    users = User
    |> Repo.all

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
         |> render("show.json", user: user)
    end
  end
end
