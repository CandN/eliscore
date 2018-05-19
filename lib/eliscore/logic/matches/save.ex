defmodule Eliscore.Logic.Matches.Save do
  alias Eliscore.{GameMatch, Repo}

  @moduledoc """
  Module responsible for saving a match result
  """

  @type input :: %{
    player1_id: pos_integer(),
    player1_score: pos_integer(),
    player2_id: pos_integer(),
    player2_score: pos_integer(),
    category_id: pos_integer(),
  }

  @spec call(params :: input) ::
    {:ok, %GameMatch{}}
    | {:error, :match_params_invalid}

  def call(params) do
    changeset = GameMatch.changeset(%GameMatch{}, params)
    case Repo.insert(changeset) do
      {:ok, match} -> {:ok, Repo.preload(match, [:player1, :player2, :category])}
      _error       -> {:error, :match_params_invalid}
    end
  end
end
