defmodule Eliscore.UsersView do
  use Eliscore.Web, :view

  def render("index.json", %{users: users}) do
    %{users: users}
  end

  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
