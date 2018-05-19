defmodule Eliscore.Logic.Users.FetchOne do
  alias Eliscore.{User, Repo}

  @moduledoc """
  This module is responsible for fetching all users
  """

  @spec call(pos_integer()) :: %User{}
  def call(user_id) do
    Repo.get(User, user_id)
  end
end
