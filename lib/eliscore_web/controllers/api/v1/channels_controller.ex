defmodule EliscoreWeb.ChannelsController do
  use EliscoreWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> render("index.json")
  end
end
