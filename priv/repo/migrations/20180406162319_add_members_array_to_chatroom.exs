defmodule Eliscore.Repo.Migrations.AddMembersArrayToChatroom do
  use Ecto.Migration

  def change do
    alter table(:chatrooms) do
      add :members, {:array, :integer}
    end
  end
end
