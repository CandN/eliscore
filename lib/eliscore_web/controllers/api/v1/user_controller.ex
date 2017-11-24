defmodule EliscoreWeb.UserController do
  use EliscoreWeb, :controller

  alias Eliscore.{ User, Repo }

  def index(conn, _params) do
    users = Repo.all(User)

    conn
    |> put_status(:ok)
    |> render("index.json", users: users)
  end

  def show(conn, %{"id" => full_name}) do
    case Repo.get_by(User, full_name: full_name) do
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
