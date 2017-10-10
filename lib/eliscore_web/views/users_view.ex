defmodule EliscoreWeb.UsersView do
  use EliscoreWeb, :view

  def render("index.json", %{users: users}) do
    %{users: users}
  end

  def render("show.json", %{user: user}) do
    %{user: user}
  end

  def render("error.json", _) do
    %{error: "User not found"}
  end

  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
