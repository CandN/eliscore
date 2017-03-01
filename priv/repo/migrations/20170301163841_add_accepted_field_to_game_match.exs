defmodule Eliscore.Repo.Migrations.AddAcceptedFieldToGameMatch do
  use Ecto.Migration

  def change do
    alter table(:game_matches) do
      add :accepted, :boolean, default: false
    end
  end
end
