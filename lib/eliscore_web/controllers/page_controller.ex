defmodule EliscoreWeb.PageController do
  use EliscoreWeb, :controller

  alias Eliscore.{Repo, Tournament}
  alias Ecto.Query

  def index(conn, _params) do
    render conn, "index.html"
  end
end
