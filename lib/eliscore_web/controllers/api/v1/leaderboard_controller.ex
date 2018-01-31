defmodule EliscoreWeb.LeaderboardController do
  use EliscoreWeb, :controller

  alias Eliscore.{ GameMatch, Repo }
  import Ecto.Query, only: [from: 2]

  def index(conn, _params) do
    q = from gm in GameMatch, select: %{wins: fragment("COUNT(CASE WHEN player1_score > player2_score THEN player1_id ELSE player2_id END) as wins"), winner: fragment("CASE WHEN player1_score > player2_score THEN u1.full_name ELSE u2.full_name END as winner")}, join: u in assoc(gm, :player1), join: u2 in assoc(gm, :player2), group_by: fragment("winner"), order_by: fragment("wins DESC")

    players = Repo.all(q)

    conn
    |> put_status(:ok)
    |> render("index.json", players: players)
  end
end
