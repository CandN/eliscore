defmodule Eliscore.Factory do
  use ExMachina.Ecto, repo: Eliscore.Repo
  use Eliscore.UserFactory
end
