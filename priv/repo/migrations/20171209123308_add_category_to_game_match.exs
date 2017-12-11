defmodule Eliscore.Repo.Migrations.AddCategoryToGameMatch do
  use Ecto.Migration

  def change do
    alter table("game_matches") do
      add :category, :string
    end
  end
end
