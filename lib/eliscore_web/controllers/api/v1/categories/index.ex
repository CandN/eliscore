defmodule EliscoreWeb.API.V1.Categories.Index do
  use Maru.Router

  @moduledoc """
  This module is responsible for making categories index endpoint
  """

  desc "Fetches all categories"
  get do
    categories = Eliscore.Logic.Categories.fetch_all()

    json(conn, %{data: categories})
  end
end
