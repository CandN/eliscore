defmodule Eliscore.Repo.Migrations.CreateGameMatch do
  use Ecto.Migration

  def change do
    create table(:game_matches) do
      add :player1_id, :integer
      add :player1_score, :integer
      add :player2_id, :integer
      add :player2_score, :integer

      timestamps
    end

  end
end
