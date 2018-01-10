defmodule Eliscore.Repo.Migrations.GameMatchBelongsToCategory do
  use Ecto.Migration

  def change do
    alter table(:game_matches) do
      add :category_id, references(:categories)
    end
  end
end
