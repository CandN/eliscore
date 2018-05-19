defmodule EliscoreWeb.API.V1.Matches.Index do
  use Maru.Router

  alias Eliscore.Logic.Matches

  @moduledoc """
  This module is responsible for making matches index endpoint
  """

  desc "Fetch matches sorted by date"
  get do
    matches = Matches.FetchAll.call()

    json(conn, %{data: matches})
  end
end
