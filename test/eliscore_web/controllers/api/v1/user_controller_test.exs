defmodule EliscoreWeb.UserControllerTest do
  use EliscoreWeb.ConnCase, async: true
  alias Eliscore.{Repo, User}

  test "index/2 responds with all Users" do
    users = [ User.changeset(%User{},%{full_name: "Test1", email: "test1@test.test", uuid: "password"}),
              User.changeset(%User{},%{full_name: "Test2", email: "test2@test.test", uuid: "password1"})]
    Enum.each(users, &Repo.insert!(&1))
    user_1 = Repo.get_by(User, full_name: "Test1")
    user_2 = Repo.get_by(User, full_name: "Test2")

    response = build_conn()
               |> get(user_path(build_conn(), :index))
               |> json_response(200)

    expected = %{
      "data" => [
        %{"full_name" => "Test1", "id" => user_1.id, "email" => "test1@test.test"},
        %{"full_name" => "Test2", "id" => user_2.id, "email" => "test2@test.test"}
      ]
    }

    assert response == expected
  end

  describe "show/2" do
    test "responds with one User" do
      user = User.changeset(%User{}, %{full_name: "Test1", email: "t@test.pl", uuid: "pass1"})
             |> Repo.insert!

      response = build_conn()
                 |> get(user_path(build_conn(), :show, user.id))
                 |> json_response(200)

      expected = %{ "data" => %{"full_name" => "Test1", "id" => user.id, "email" => "t@test.pl" } }
      assert response == expected
    end

    test "responds with a message User not found " do
      response = build_conn()
                 |> get(user_path(build_conn(), :show, 300))
                 |> json_response(404)

      expected = %{ "error" => "User not found." }

      assert response == expected

    end
  end
end
