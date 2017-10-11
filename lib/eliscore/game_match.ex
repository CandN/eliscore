defmodule Eliscore.GameMatch do
  use Ecto.Schema
  import Ecto.{ Changeset, Query }
  alias Eliscore.GameMatch

  @derive {Poison.Encoder, only: [:id, :player1, :player2, :player1_score, :player2_score]}

  schema "game_matches" do
    field :accepted, :boolean, default: false
    belongs_to :player1, Eliscore.User, foreign_key: :player1_id
    field :player1_score, :integer
    belongs_to :player2, Eliscore.User, foreign_key: :player2_id
    field :player2_score, :integer

    timestamps()
  end

  @required_fields ~w(player1_id player1_score player2_id player2_score)
  @optional_fields ~w(accepted)

  @doc false
  def changeset(%GameMatch{} = game_match, attrs) do
    game_match
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required([:player1_id, :player1_score, :player2_id, :player2_score])
  end

  def accepted(query) do
    from q in query,
      where: q.accepted == true,
      select: q 
  end

  def with_players(query) do
    from q in query, preload: [:player1, :player2]
  end

  def winner(game_match = %{player1_score: score1, player2_score: score2}) 
  when score1 > score2 do 
    game_match.player1.login
  end

  def winner(game_match = %{player1_score: score1, player2_score: score2}) 
  when score2 > score1 do 
    game_match.player2.login
  end

  def winner(_), do: :draw
end
