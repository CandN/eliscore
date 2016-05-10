defmodule Eliscore.PageController do
  use Eliscore.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
