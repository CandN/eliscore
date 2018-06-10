defmodule EliscoreWeb.API.V1.Tournaments.Base do
  use Maru.Router
  alias EliscoreWeb.API.V1.Tournaments

  @moduledoc """
  This module is responsible for mounting all tournaments actions
  """

  namespace :tournaments do
    mount Tournaments.Date
  end
end
