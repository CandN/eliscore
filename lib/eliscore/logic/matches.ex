defmodule Eliscore.Logic.Matches do
  alias Eliscore.{GameMatch, Repo}
  import Ecto.Query, only: [preload: 2]

  @moduledoc """
  This module is responsible for handling all match
  related logic actions
  """

  @type input :: %{
    player1_id: pos_integer(),
    player1_score: pos_integer(),
    player2_id: pos_integer(),
    player2_score: pos_integer(),
    category_id: pos_integer(),
  }

  @spec save(params :: input) ::
  {:ok, %GameMatch{}}
  | {:error, :match_params_invalid}

  def save(params) do
    changeset = GameMatch.changeset(%GameMatch{}, params)
    case Repo.insert(changeset) do
      {:ok, match} -> {:ok, Repo.preload(match, [:player1, :player2, :category])}
      _error       -> {:error, :match_params_invalid}
    end
  end

  @spec fetch_all() :: list(GameMatch)
  def fetch_all() do
    GameMatch.newest()
    |> preload([:player1, :player2])
    |> Repo.all
  end
end
