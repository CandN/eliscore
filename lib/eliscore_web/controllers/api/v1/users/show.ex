defmodule EliscoreWeb.API.V1.Users.Show do
  use Maru.Router

  alias Eliscore.{User, Logic.Users}

  @moduledoc """
  This module is responsible for making user show endpoint
  """

  desc "Fetches certain users"
  route_param :id do
    get do
      with %Eliscore.User{} = user <- Users.fetch_one(params[:id]) do
        json(conn, %{data: user})
      else
        _error -> json(conn, %{error: "wrong id provided"})
      end
    end
  end
end
