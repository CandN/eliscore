defmodule EliscoreWeb.UserController do
  use EliscoreWeb, :controller

  alias Eliscore.{ User, Repo }

  def index(conn, _params) do
    users = Repo.all(User)

    conn
    |> put_status(:ok)
    |> render("index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    case Repo.get_by(User, id: id) do
      nil ->
        conn
        |> put_status(404)
        |> render("error.json")
      user ->
        conn
        |> put_status(:ok)
        |> render("show.json", user: user)
    end
  end
end
