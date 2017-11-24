defmodule Eliscore.Repo.Migrations.ChangeNullOnUsersTableAttributes do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :login, :string, null: true
      modify :uuid, :string, null: false
      modify :encrypted_password, :string, null: true
    end
  end
end
