require IEx

defmodule Eliscore.PageController do
  use Eliscore.Web, :controller

  def index(conn, _params) do
    #IEx.pry
    render conn, "index.html"
  end
end
