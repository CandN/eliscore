defmodule Eliscore.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :author_id, :integer
      add :body, :text

      timestamps()
    end
  end
end
