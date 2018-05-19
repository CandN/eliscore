defmodule EliscoreWeb.API.V1.CurrentUser.Show do
  use Maru.Router

  alias Eliscore.{User, Logic.CurrentUser}

  @moduledoc """
  This module is responsible for making current user endpoint
  """

  desc "Fetches current user"
  get do
    with %User{} = user <- CurrentUser.Fetch.call(conn) do
      json(conn, %{data: user})
    else
      _error -> json(conn, %{error: "Wrong token provided"})
    end
  end
end
