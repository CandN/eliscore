defmodule EliscoreWeb.TournamentView do
  use EliscoreWeb, :view
  alias EliscoreWeb.TournamentView

  def render("start_date.json", %{tournament: tournament}) do
    %{data: render_one(tournament, TournamentView, "tournament.json")}
  end

  def render("tournament.json", %{tournament: tournament}) do
    %{id: tournament.id,
      start_date: tournament.start_date}
  end
end
