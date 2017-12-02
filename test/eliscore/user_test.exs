defmodule Eliscore.UserTest do
  use Eliscore.DataCase

  alias Eliscore.User

  @valid_attrs %{
    full_name: "John Doe", 
    first_name: "John", 
    last_name: "Doe", 
    email: "email@test.com", 
    uuid: "1234567890",
    image_url: "some/url"
  }
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
