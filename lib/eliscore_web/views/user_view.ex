defmodule EliscoreWeb.UserView do
  use EliscoreWeb, :view
  alias EliscoreWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, full_name: user.full_name, email: user.email, image_url: user.image_url}
  end

  def render("error.json", _) do
    %{error: "User not found."}
  end

  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
