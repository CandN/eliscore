defmodule Eliscore.GameMatchTest do
  use Eliscore.ModelCase

  alias Eliscore.GameMatch

  @valid_attrs %{player1_id: 42, player1_score: 42, player2_id: 42, player2_score: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = GameMatch.changeset(%GameMatch{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = GameMatch.changeset(%GameMatch{}, @invalid_attrs)
    refute changeset.valid?
  end
end
