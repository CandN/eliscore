defmodule Eliscore.MatchesView do
  use Eliscore.Web, :view

  def render("index.json", %{matches: matches}) do
    %{matches: matches}
  end

  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
