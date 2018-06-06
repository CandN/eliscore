defmodule EliscoreWeb.API.V1.Registrations.Base do
  use Maru.Router, make_plug: true
  alias EliscoreWeb.API.V1.Registrations

  @moduledoc """
  This module is responsible for mounting all registrations actions
  """

  mount Registrations.Create
end
