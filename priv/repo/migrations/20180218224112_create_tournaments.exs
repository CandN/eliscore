defmodule Eliscore.Repo.Migrations.CreateTournaments do
  use Ecto.Migration

  def change do
    create table(:tournaments) do
      add :start_date, :utc_datetime, null: false

      timestamps()
    end
  end
end
