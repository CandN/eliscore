defmodule Eliscore.Logic.Users do
  alias Eliscore.{User, Repo}

  @moduledoc """
  This module is responsible for handling all user
  related actions
  """

  @spec fetch_all() :: list(User)
  def fetch_all() do
    Repo.all(User)
  end

  @spec fetch_one(pos_integer()) :: %User{}
  def fetch_one(user_id) do
    Repo.get(User, user_id)
  end
end
