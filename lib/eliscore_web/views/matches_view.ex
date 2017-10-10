defmodule EliscoreWeb.MatchesView do
  use EliscoreWeb, :view

  def render("index.json", %{matches: matches}) do
    %{matches: matches}
  end

  def render("show.json", %{match: match}) do
    %{match: match}
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
