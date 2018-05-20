defmodule EliscoreWeb.API.V1.Tournaments.Date do
  use Maru.Router
  alias Eliscore.Logic.Tournaments

  @moduledoc """
  This module is responsible for creating torunament date endpoint
  """

  namespace :date do
    get do
      tournament = Tournaments.fetch_date()
      json(conn, %{data: tournament})
    end
  end
end
