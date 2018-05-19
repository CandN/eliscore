defmodule Eliscore.Logic.Matches.FetchAll do
  alias Eliscore.{GameMatch, Repo}
  import Ecto.Query, only: [preload: 2]

  @moduledoc """
  This module is responsible for fetching all matches
  sorted by the newest
  """

  @spec call() :: list(GameMatch)
  def call() do
    GameMatch.newest()
    |> preload([:player1, :player2])
    |> Repo.all
  end
end
