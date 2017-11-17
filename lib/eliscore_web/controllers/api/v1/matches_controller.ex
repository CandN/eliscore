defmodule EliscoreWeb.MatchesController do
  use EliscoreWeb, :controller

  alias Eliscore.{ GameMatch, Repo }

  def index(conn, _params) do
    matches = GameMatch
              |> Repo.all
              |> Repo.preload([:player1, :player2])

    conn
    |> put_status(:ok)
    |> render("index.json", matches: matches)
  end

  plug :scrub_params, "game_match" when action in [:create]

  def create(conn, %{"game_match" => game_match_params}) do
    changeset = GameMatch.changeset(%GameMatch{}, game_match_params)

    case Repo.insert(changeset) do
      {:ok, game_match} ->
        match = Repo.preload(game_match, [:player1, :player2])

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
