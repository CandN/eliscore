defmodule EliscoreWeb.API.V1.Matches.Base do
  use Maru.Router
  alias EliscoreWeb.API.V1.Matches

  @moduledoc """
  This module is responsible for mounting all matches actions
  """

  namespace :matches do
    mount Matches.Index
    mount Matches.Create
  end
end
