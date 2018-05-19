defmodule Eliscore.Logic.Categories.FetchAll do
  alias Eliscore.Model

  @moduledoc """
  This module is responsible for fetching all categories
  """

  @spec call() :: list(Category)
  def call() do
    Model.list_categories()
  end
end
