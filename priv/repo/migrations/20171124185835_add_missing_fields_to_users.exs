defmodule Eliscore.Repo.Migrations.AddMissingFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :full_name, :string
      add :image_url, :string
      add :first_name, :string
      add :last_name, :string
      add :uuid, :string
    end
  end
end
