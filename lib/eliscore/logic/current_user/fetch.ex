defmodule Eliscore.Logic.CurrentUser.Fetch do
  alias Eliscore.{User, Guardian}

  @moduledoc """
  This module is responsible for fetching current user
  """

  @spec call(map()) :: %User{}
  def call(conn) do
    Guardian.Plug.current_resource(conn)
  end
end
