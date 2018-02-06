defmodule EliscoreWeb.LeaderboardController do
  use EliscoreWeb, :controller

  alias Eliscore.{ User, Repo }
  import Ecto.Query, only: [from: 2]

  def fifa(conn, _params) do
    query = from u in User,
    select: %{
      full_name: u.full_name,
      wins: fragment("(
        SELECT COUNT(*)
        FROM game_matches
        JOIN categories c ON c.id = category_id
        WHERE ((player1_id = u0.id AND player1_score > player2_score)
          OR (player2_id = u0.id AND player2_score > player1_score))
          AND c.name = 'fifa'
        ) AS wins"),
      loses: fragment("(
        SELECT COUNT(*)
        FROM game_matches
        JOIN categories c ON c.id = category_id
        WHERE ((player1_id = u0.id AND player1_score < player2_score)
           OR (player2_id = u0.id AND player2_score < player1_score))
           AND c.name = 'fifa'
        ) AS loses"),
      draws: fragment("(
        SELECT COUNT(*)
        FROM game_matches
        JOIN categories c ON c.id = category_id
        WHERE (player1_score = player2_score
          AND (player1_id = u0.id OR player2_id = u0.id))
          AND c.name = 'fifa'
        ) AS draws"),
      all_games: fragment("(
        SELECT COUNT(*)
        FROM game_matches
        JOIN categories c ON c.id = category_id
        WHERE ((player1_id = u0.id)
           OR (player2_id = u0.id))
           AND c.name = 'fifa'
        ) AS all_games")
    }

    stats = Repo.all(query)
    |> Enum.map(&add_points_to_player_fifa/1)
    |> Enum.sort_by(fn(map) -> {-map.points, map.all_games} end)

    conn
    |> put_status(:ok)
    |> render("fifa.json", player_stats: stats)
  end

  def fusball(conn, _params) do
    query = from u in User,
    select: %{
      full_name: u.full_name,
      wins: fragment("(
        SELECT COUNT(*)
        FROM game_matches
        JOIN categories c ON c.id = category_id
        WHERE ((player1_id = u0.id AND player1_score > player2_score)
          OR (player2_id = u0.id AND player2_score > player1_score))
          AND c.name = 'fusball'
        ) AS wins"),
      loses: fragment("(
        SELECT COUNT(*)
        FROM game_matches
        JOIN categories c ON c.id = category_id
        WHERE ((player1_id = u0.id AND player1_score < player2_score)
           OR (player2_id = u0.id AND player2_score < player1_score))
           AND c.name = 'fusball'
        ) AS loses"),
      all_games: fragment("(
        SELECT COUNT(*)
        FROM game_matches
        JOIN categories c ON c.id = category_id
        WHERE ((player1_id = u0.id)
           OR (player2_id = u0.id))
           AND c.name = 'fusball'
        ) AS all_games")
    }

    stats = Repo.all(query)
    |> Enum.map(&add_points_to_player_fusball/1)
    |> Enum.sort_by(fn(map) -> -map.points end)

    conn
    |> put_status(:ok)
    |> render("fusball.json", player_stats: stats)
  end

  defp add_points_to_player_fifa(player_stats = %{wins: wins, draws: draws}) do
    Map.put(player_stats, :points, 3 * wins + draws)
  end

  defp add_points_to_player_fusball(player_stats = %{wins: wins}) do
    Map.put(player_stats, :draws, 0)
    |> Map.put(:points, wins)
  end
end
