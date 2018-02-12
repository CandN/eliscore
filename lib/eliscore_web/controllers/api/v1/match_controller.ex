defmodule EliscoreWeb.MatchController do
  use EliscoreWeb, :controller
  import Ecto.Query

  alias Eliscore.{ GameMatch, Repo }

  def index(conn, params) do
    matches = GameMatch
              |> GameMatch.newest
              |> preload([:player1, :player2, :category])
              # TODO: Backend pagination temporarily disabled
              # |> Repo.paginate(params)
              |> Repo.all

    conn
    |> put_status(:ok)
    |> render("index.json", matches: matches)
  end

  plug :scrub_params, "game_match" when action in [:create]

  def create(conn, %{"game_match" => game_match_params}) do
    changeset = GameMatch.changeset(%GameMatch{}, game_match_params)

    case Repo.insert(changeset) do
      {:ok, game_match} ->
        match = Repo.preload(game_match, [:player1, :player2, :category])

        conn
        |> put_status(:created)
        |> render("show.json", match: match)

      {:error, changeset} ->

        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", changeset: changeset)
    end
  end
end
