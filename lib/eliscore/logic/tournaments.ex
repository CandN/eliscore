defmodule Eliscore.Logic.Tournaments do
  alias Eliscore.{Repo, Tournament}
  import Ecto.Query, only: [first: 2]

  @moduledoc """
  This module is responsible for handling all tournament
  related actions
  """

  @spec fetch_date() :: %Tournament{}
  def fetch_date() do
    Tournament |> first(:start_date) |> Repo.one
  end
end
