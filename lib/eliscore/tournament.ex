defmodule Eliscore.Tournament do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eliscore.Tournament


  @derive {Jason.Encoder, only: [:id, :start_date]}
  schema "tournaments" do
    field :start_date, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(%Tournament{} = tournament, attrs) do
    tournament
    |> cast(attrs, [:start_date])
    |> validate_required([:start_date])
  end
end
