defmodule EliscoreWeb.ChannelsView do
  use EliscoreWeb, :view
  alias EliscoreWeb.ChannelsView

  def render("index.json", _params) do
    %{data: %{id: 123}}
  end

  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
