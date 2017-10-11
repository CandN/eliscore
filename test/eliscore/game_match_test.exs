defmodule Eliscore.GameMatchTest do
  use Eliscore.DataCase

  alias Eliscore.GameMatch 

  @player1 %{id: 1, login: "player1", email: "email1@test.com", password: "password" }
  @player2 %{id: 2, login: "player2", email: "email2@test.com", password: "password" }
  @valid_attrs %{player1_id: @player1.id, player1_score: 10, 
    player2_id: @player2.id, player2_score: 8}
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
