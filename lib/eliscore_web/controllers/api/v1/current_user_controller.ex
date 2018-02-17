defmodule EliscoreWeb.CurrentUserController do
  use EliscoreWeb, :controller

  def show(conn, _) do
    case Eliscore.Guardian.Plug.current_resource(conn) do
      %Eliscore.User{} = user ->
        conn
        |> put_status(:ok)
        |> render("show.json", user: user)
      nil ->
        conn
        |> put_status(404)
        |> render("error.json", error: "Wrong token provided")
    end
  end
end
