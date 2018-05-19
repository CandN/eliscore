defmodule EliscoreWeb.API.V1.Categories.Base do
  use Maru.Router
  alias EliscoreWeb.API.V1.Categories

  @moduledoc """
  This module is responsible for mounting all categories actions
  """

  namespace :categories do
    mount Categories.Index
  end
end
