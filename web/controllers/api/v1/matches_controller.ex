defmodule Eliscore.MatchesController do
  use Eliscore.Web, :controller

  alias Eliscore.GameMatch

  def index(conn, _params) do
    matches = GameMatch
    |> Repo.all
    |> Repo.preload([:player1, :player2])

    conn
    |> put_status(:ok)
    |> render("index.json", matches: matches)
  end
end
