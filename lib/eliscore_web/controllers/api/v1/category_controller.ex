defmodule EliscoreWeb.CategoryController do
  use EliscoreWeb, :controller

  alias Eliscore.Model
  alias Eliscore.Model.Category

  action_fallback EliscoreWeb.FallbackController

  def index(conn, _params) do
    categories = Model.list_categories()
    render(conn, "index.json", categories: categories)
  end
end
