defmodule EliscoreWeb.CurrentUserView do
  use EliscoreWeb, :view

  def render("show.json", %{user: user}), do: %{data: user}
  def render("error.json", %{error: error}), do: %{data: error}
end
