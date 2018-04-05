defmodule Eliscore.Repo.Migrations.CreateChatrooms do
  use Ecto.Migration

  def change do
    create table(:chatrooms) do
      add :name, :string

      timestamps()
    end
  end
end
