defmodule Eliscore.Repo.Migrations.CreateTournamentDates do
  use Ecto.Migration

  def change do
    create table(:tournament_dates) do
      add :date, :utc_datetime, null: false

      timestamps()
    end
  end
end
