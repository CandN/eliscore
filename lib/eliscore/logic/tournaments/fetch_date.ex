defmodule Eliscore.Logic.Tournaments.FetchDate do
  alias Eliscore.{Repo, Tournament}
  import Ecto.Query, only: [first: 2]

  @moduledoc """
  This module is responsible for fetching the tournament date
  """

  @spec call() :: %Tournament{}
  def call() do
    Tournament |> first(:start_date) |> Repo.one
  end
end
