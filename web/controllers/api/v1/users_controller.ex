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
end
