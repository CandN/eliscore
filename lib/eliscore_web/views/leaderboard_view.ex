defmodule EliscoreWeb.LeaderboardView do
  use EliscoreWeb, :view
  alias EliscoreWeb.LeaderboardView

  def render("fifa.json", %{player_stats: player_stats}) do
    %{data: render_many(player_stats, LeaderboardView, "player.json")}
  end

  def render("fusball.json", %{player_stats: player_stats}) do
    %{data: render_many(player_stats, LeaderboardView, "player.json")}
  end

  def render("player.json", %{leaderboard: player_stat}) do
    %{
      full_name: player_stat.full_name,
      wins: player_stat.wins,
      loses: player_stat.loses,
      draws: player_stat.draws,
      all_games: player_stat.all_games,
      points: player_stat.points
    }
  end

  def render("error.json", _) do
    %{error: "User not found."}
  end

  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
