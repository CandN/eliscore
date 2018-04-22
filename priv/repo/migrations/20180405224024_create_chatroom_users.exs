defmodule Eliscore.Repo.Migrations.CreateChatroomUsers do
  use Ecto.Migration

  def change do
    create table(:chatroom_users) do
      add :chatroom_id, references(:chatrooms)
      add :user_id, references(:users)

      timestamps()
    end
  end
end
