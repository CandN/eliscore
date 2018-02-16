defmodule EliscoreWeb.MatchView do
  use EliscoreWeb, :view
  alias EliscoreWeb.{MatchView, UserView}

  def render("index.json", %{matches: matches}) do
    %{data: render_many(matches, MatchView, "match.json")}
  end

  def render("show.json", %{match: match}) do
    %{data: render_one(match, MatchView, "match.json")}
  end

  def render("match.json", %{match: match}) do
    %{
      id: match.id,
      accepted: match.accepted,
      player1: render(UserView, "user.json", user: match.player1),
      player1_score: match.player1_score,
      player2: render(UserView, "user.json", user: match.player2),
      player2_score: match.player2_score,
      category_id: match.category_id,
    }
  end

  def render("error.json", %{changeset: changeset}) do
    errors = Enum.map(changeset.errors, fn {field, detail} ->
      %{} |> Map.put(field, detail)
    end)

    %{errors: errors}
  end

  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
