defmodule Eliscore.Model.TournamentDate do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eliscore.Model.TournamentDate


  schema "tournament_dates" do
    field :date, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(%TournamentDate{} = date, attrs) do
    date
    |> cast(attrs, [:date])
    |> validate_required([:date])
  end
end
