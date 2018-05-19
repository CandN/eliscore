defmodule EliscoreWeb.API.V1.Registrations.Base do
  use Maru.Router
  alias EliscoreWeb.API.V1.Registrations

  @moduledoc """
  This module is responsible for mounting all registrations actions
  """

  namespace :registrations do
    mount Registrations.Create
  end
end
