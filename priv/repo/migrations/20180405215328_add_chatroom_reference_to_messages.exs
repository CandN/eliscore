defmodule Eliscore.Repo.Migrations.AddChatroomReferenceToMessages do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      add :chatroom_id, references(:chatrooms)
    end
  end
end
