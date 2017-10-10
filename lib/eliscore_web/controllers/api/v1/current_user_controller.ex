defmodule EliscoreWeb.CurrentUserController do
  use EliscoreWeb, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: EliscoreWeb.SessionController

  def show(conn, _) do
    user = Guardian.Plug.current_resource(conn)

    conn
    |> put_status(:ok)
    |> render("show.json", user: user)
  end
end
