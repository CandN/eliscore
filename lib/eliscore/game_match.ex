defmodule Eliscore.GameMatch do
  use Ecto.Schema
  import Ecto.{Changeset, Query}
  alias Eliscore.GameMatch

  @derive {Jason.Encoder, only: [
              :id,
              :player1,
              :player1_score,
              :player2,
              :player2_score,
              :category_id
            ]}

  schema "game_matches" do
    field :accepted, :boolean, default: false
    belongs_to :player1, Eliscore.User, foreign_key: :player1_id
    field :player1_score, :integer
    belongs_to :player2, Eliscore.User, foreign_key: :player2_id
    field :player2_score, :integer
    belongs_to :category, Eliscore.Model.Category, foreign_key: :category_id

    timestamps()
  end

  @permitted_params ~w(
    player1_id
    player1_score
    player2_id
    player2_score
    category_id
    accepted
  )a

  @required_params ~w(
    player1_id
    player1_score
    player2_id
    player2_score
    category_id
  )a

  @spec changeset(%GameMatch{}, map()) :: map()
  def changeset(%GameMatch{} = game_match, attrs) do
    game_match
    |> cast(attrs, @permitted_params)
    |> validate_required(@required_params)
  end

  @spec accepted() :: %Ecto.Query{}
  def accepted() do
    from q in __MODULE__,
      where: q.accepted == true,
      select: q
  end

  @spec newest() :: %Ecto.Query{}
  def newest() do
    from q in __MODULE__,
      order_by: [desc: q.inserted_at],
      select: q
  end

  @spec with_players() :: %Ecto.Query{}
  def with_players() do
    from q in __MODULE__, preload: [:player1, :player2]
  end
end
