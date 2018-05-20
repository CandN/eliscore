defmodule Eliscore.Logic.CurrentUser do
  alias Eliscore.{User, Guardian}

  @moduledoc """
  This module is responsible for handling all
  current user related logic actions
  """

  @spec fetch(map()) :: %User{}
  def fetch(conn) do
    Guardian.Plug.current_resource(conn)
  end
end
