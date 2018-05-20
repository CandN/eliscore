defmodule EliscoreWeb.API.V1.Users.Index do
  use Maru.Router

  @moduledoc """
  This module is responsible for making users index endpoint
  """

  desc "Fetches all users"
  get do
    users = Eliscore.Logic.Users.fetch_all()

    json(conn, %{data: users})
  end
end
