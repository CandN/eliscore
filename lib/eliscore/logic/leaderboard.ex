defmodule Eliscore.Logic.Leaderboard do
  import Ecto.Query, only: [from: 2]
  alias Eliscore.{User, Repo}

  @moduledoc """
  This module is responsible for handling all leaderboard
  related logic actions
  """

  @spec calculate() :: list(map())
  def calculate() do
    leaderboard_query()
    |> Repo.all()
    |> Enum.map(&add_points_to_player/1)
    |> Enum.sort_by(fn(map) -> {-map.points, map.all_games} end)
  end

  defp leaderboard_query() do
    from u in User,
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
  end

  defp add_points_to_player(player_stats = %{wins: wins, draws: draws}) do
    Map.put(player_stats, :points, 3 * wins + draws)
  end
end
