defmodule EliscoreWeb.LeaderboardView do
  use EliscoreWeb, :view
  alias EliscoreWeb.LeaderboardView

  def render("index.json", %{players: players}) do
    %{data: render_many(players, LeaderboardView, "player.json")}
  end

  def render("player.json", %{leaderboard: player}) do
    %{full_name: player.winner, wins: player.wins}
  end

  def render("error.json", _) do
    %{error: "User not found."}
  end

  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
