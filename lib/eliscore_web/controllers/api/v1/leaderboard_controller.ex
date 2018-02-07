defmodule EliscoreWeb.LeaderboardController do
  use EliscoreWeb, :controller

  alias Eliscore.{ User, Repo }
  import Ecto.Query, only: [from: 2]

  def index(conn, _params) do
    q = from u in User,
    select: %{
      full_name: u.full_name,
      wins: fragment("(
        SELECT COUNT(*)
        FROM game_matches
        WHERE (player1_id = u0.id AND player1_score > player2_score)
          OR (player2_id = u0.id AND player2_score > player1_score)
        ) AS wins"),
      loses: fragment("(
        SELECT COUNT(*)
        FROM game_matches
        WHERE (player1_id = u0.id AND player1_score < player2_score)
           OR (player2_id = u0.id AND player2_score < player1_score)
        ) AS loses"),
      draws: fragment("(
        SELECT COUNT(*)
        FROM game_matches
        WHERE player1_score = player2_score
          AND (player1_id = u0.id OR player2_id = u0.id)
        ) AS draws"),
      all_games: fragment("(
        SELECT COUNT(*)
        FROM game_matches
        WHERE (player1_id = u0.id)
           OR (player2_id = u0.id)
        ) AS all_games")
    }

    players = Repo.all(q)
    |> Enum.map(&add_points_to_player/1)
    |> Enum.sort_by(fn(map) -> {-map.points, map.all_games} end)

    conn
    |> put_status(:ok)
    |> render("index.json", players: players)
  end

  defp add_points_to_player(player_stats = %{wins: wins, draws: draws}) do
    Map.put(player_stats, :points, 3 * wins + draws)
  end
end
