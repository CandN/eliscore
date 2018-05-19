defmodule EliscoreWeb.API.V1.Leaderboard.Index do
  use Maru.Router

  alias Eliscore.Logic.Leaderboard

  @moduledoc """
  This module is responsible for making leaderboard index endpoint
  """

  desc "Fetch leaderboard statistics"
  get do
    leaderboard = Leaderboard.Calculate.call()

    json(conn, %{data: leaderboard})
  end
end
