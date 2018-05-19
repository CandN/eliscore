defmodule EliscoreWeb.API.V1.Base do
  use Maru.Router

  alias EliscoreWeb.API.V1.{
    Matches,
    Users,
    CurrentUser,
    Leaderboard,
    Categories,
    Registrations,
    Tournaments
  }

  @moduledoc """
  This module is responsible for mounting all base endpoints
  """

  version "v1"

  mount Matches.Base
  mount Users.Base
  mount CurrentUser.Base
  mount Leaderboard.Base
  mount Categories.Base
  mount Registrations.Base
  mount Tournaments.Base
end
