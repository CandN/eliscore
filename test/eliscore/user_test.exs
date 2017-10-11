defmodule Eliscore.UserTest do
  use Eliscore.DataCase

  alias Eliscore.User

  @valid_attrs %{login: "login", email: "email@test.com", password: "password" }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
