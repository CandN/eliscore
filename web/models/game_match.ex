defmodule Eliscore.GameMatch do
  use Eliscore.Web, :model

  schema "game_matches" do
    belongs_to :player1, Eliscore.User, foreign_key: :player1_id
    field :player1_score, :integer
    belongs_to :player2, Eliscore.User, foreign_key: :player2_id
    field :player2_score, :integer

    timestamps
  end

  @required_fields ~w(player1_id player1_score player2_id player2_score)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def with_players(query) do
    from q in query, preload: [:player1, :player2]
  end

  def winner(game_match) do
    if game_match.player1_score > game_match.player2_score do
      game_match.player1.login;
    else
      game_match.player2.login;
    end
  end
end
