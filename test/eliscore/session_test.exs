defmodule Eliscore.SessionTest do
  use Eliscore.DataCase, async: true

  alias Eliscore.{Repo, User, Session}

  @user_params %{login: "Test1", email: "test1@test.pl", password: "pass"}

  describe "#authenticate" do
    test "when email is in database" do
      User.changeset(%User{}, @user_params)
                  |> Repo.insert!
      user = Repo.get_by(User, login: "Test1")

      assert Session.authenticate(
        %{
          "email" => "test1@test.pl", 
          "password" => "pass"
        }
      ) == {:ok, user }
    end

    test "when email is not in database" do
      assert Session.authenticate(
        %{
          "email" => "test1@test.pl", 
          "password" => "pass"
        }
      ) == :error

    end
  end
end
