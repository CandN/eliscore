defmodule EliscoreWeb.API.V1.Leaderboard.Base do
  use Maru.Router
  alias EliscoreWeb.API.V1.Leaderboard

  @moduledoc """
  This module is responsible for mounting all matches actions
  """

  namespace :leaderboard do
    mount Leaderboard.Index
  end
end
