defmodule Eliscore.GameMatch do
  use Ecto.Schema
  import Ecto.{ Changeset, Query }
  alias Eliscore.GameMatch

  @derive {Poison.Encoder, only: [:id, :player1_id, :player2_id, :player1_score, :player2_score]}
  schema "game_matches" do
    field :accepted, :boolean, default: false
    belongs_to :player1, Eliscore.User, foreign_key: :player1_id
    field :player1_score, :integer
    belongs_to :player2, Eliscore.User, foreign_key: :player2_id
    field :player2_score, :integer
    belongs_to :category, Eliscore.Model.Category, foreign_key: :category_id

    timestamps()
  end

  @permitted_params ~w(player1_id player1_score player2_id player2_score category_id accepted)a
  @required_params ~w(player1_id player1_score player2_id player2_score)a

  @doc false
  def changeset(%GameMatch{} = game_match, attrs) do
    game_match
    |> cast(attrs, @permitted_params)
    |> validate_required(@required_params)

  end

  def accepted(query) do
    from q in query,
      where: q.accepted == true,
      select: q
  end

  def newest(query) do
    from q in query,
      order_by: [desc: q.inserted_at],
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
