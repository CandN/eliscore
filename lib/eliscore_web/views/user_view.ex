defmodule EliscoreWeb.UserView do
  use EliscoreWeb, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, EliscoreWeb.UserView, "user.json")}
  end
  
  def render("show.json", %{user: user}) do
    %{data: render_one(user, EliscoreWeb.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{login: user.login, email: user.email}
  end

  def render("error.json", _) do
    %{error: "User not found."}
  end

  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
