defmodule Eliscore.Logic.Users.FetchAll do
  alias Eliscore.{User, Repo}

  @moduledoc """
  This module is responsible for fetching all users
  """

  @spec call() :: list(User)
  def call() do
    Repo.all(User)
  end
end
