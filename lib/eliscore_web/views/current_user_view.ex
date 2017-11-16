defmodule EliscoreWeb.CurrentUserView do
  use EliscoreWeb, :view

  def render("show.json", %{user: user}), do: user
  def render("error.json", _) do
  end
end
