defmodule EliscoreWeb.API.V1.CurrentUser.Base do
  use Maru.Router
  alias EliscoreWeb.API.V1.CurrentUser

  @moduledoc """
  This module is responsible for mounting current_user actions
  """

  namespace :current_user do
    mount CurrentUser.Show
  end
end
