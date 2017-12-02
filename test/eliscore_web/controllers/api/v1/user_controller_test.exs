defmodule EliscoreWeb.UserControllerTest do
  use EliscoreWeb.ConnCase, async: true
  alias Eliscore.{Repo, User}

  test "index/2 responds with all Users" do
    users = [ 
      User.changeset(
        %User{},%{
          full_name: "John Doe", 
          first_name: "John", 
          last_name: "Doe", 
          image_url: "image/url",
          uuid: "11111111",
          email: "test1@test.test", 
          password: "password"
        }),
      User.changeset(
        %User{},%{
          full_name: "Dohn Joe", 
          first_name: "Dohn", 
          last_name: "Joe", 
          image_url: "image/url",
          uuid: "11111111",
          email: "test2@test.test", 
          password: "password"
        })]

    Enum.each(users, &Repo.insert!(&1))
    user_1 = Repo.get_by(User, first_name: "John")
    user_2 = Repo.get_by(User, first_name: "Dohn")
    response = build_conn()
               |> get(user_path(build_conn(), :index))
               |> json_response(200)

    expected = %{
      "data" => [
        %{"full_name" => "John Doe", "id" => user_1.id, "email" => "test1@test.test"},
        %{"full_name" => "Dohn Joe", "id" => user_2.id, "email" => "test2@test.test"}
      ]
    }

    assert response == expected
  end

  describe "show/2" do
    test "responds with one User" do
      User.changeset(
        %User{}, %{
          full_name: "John Doe", 
          first_name: "John", 
          last_name: "Doe", 
          image_url: "image/url",
          uuid: "11111111",
          email: "test3@test.test", 
          password: "password"
        })
        |> Repo.insert!

      user_1 = Repo.get_by!(User, first_name: "John")

      response = build_conn()
                 |> get(user_path(build_conn(), :index, user_1))
                 |> json_response(200)

      expected = %{ "data" => %{"full_name" => "John Doe", "id" => user_1.id, "email" => "test3@test.test" }}
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
