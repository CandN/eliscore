defmodule Eliscore.Repo.Migrations.RemoveCategoryNameStringFromGameMatches do
  use Ecto.Migration

  def change do
    alter table(:game_matches) do
      remove :category
    end
  end
end
