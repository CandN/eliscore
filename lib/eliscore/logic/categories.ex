defmodule Eliscore.Logic.Categories do
  alias Eliscore.Model

  @moduledoc """
  This module is responsible for handling all category
  related logic actions
  """

  @spec fetch_all() :: list(Category)
  def fetch_all() do
    Model.list_categories()
  end
end
