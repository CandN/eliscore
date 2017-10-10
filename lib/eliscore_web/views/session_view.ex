defmodule EliscoreWeb.SessionView do
  use EliscoreWeb, :view

  def render("show.json", %{jwt: jwt, user: user}) do
    %{
      jwt: jwt,
      user: user
    }
  end

  def render("error.json", _), do: %{error: "Invalid email or password"}

  def render("delete.json", _), do: {:ok, true}

  def render("forbidden.json", %{error: error}), do: %{error: error}
end
