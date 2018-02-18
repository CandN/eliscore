defmodule EliscoreWeb.PageController do
  use EliscoreWeb, :controller

  alias Eliscore.{Repo, Model.TournamentDate}
  alias Ecto.Query

  def index(conn, _params) do
    date = TournamentDate |> Query.first(:date) |> Repo.one
    tournament_date = date.date |> DateTime.to_string
    render conn, "index.html", date: tournament_date
  end
end
