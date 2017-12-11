defmodule Eliscore.Repo.Migrations.AddCityToUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :city, :string
    end
  end
end
