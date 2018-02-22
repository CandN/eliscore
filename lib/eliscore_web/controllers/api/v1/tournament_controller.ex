defmodule EliscoreWeb.TournamentController do
  use EliscoreWeb, :controller

  alias Eliscore.{Repo, Tournament}
  alias Ecto.Query

  action_fallback EliscoreWeb.FallbackController

  def date(conn, _params) do
    tournament = Tournament|> Query.first(:start_date) |> Repo.one
    render(conn, "start_date.json", tournament: tournament)
  end
end
