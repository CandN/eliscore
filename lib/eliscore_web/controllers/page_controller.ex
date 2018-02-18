defmodule EliscoreWeb.PageController do
  use EliscoreWeb, :controller

  alias Eliscore.{Repo, Tournament}
  alias Ecto.Query

  def index(conn, _params) do
    date = Tournament|> Query.first(:start_date) |> Repo.one
    tournament_date = date.start_date |> DateTime.to_string
    render conn, "index.html", date: tournament_date
  end
end
