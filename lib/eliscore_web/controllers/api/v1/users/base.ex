defmodule EliscoreWeb.API.V1.Users.Base do
  use Maru.Router
  alias EliscoreWeb.API.V1.Users

  @moduledoc """
  This module is responsible for mounting all users actions
  """

  namespace :users do
    mount Users.Index
    mount Users.Show
  end
end
