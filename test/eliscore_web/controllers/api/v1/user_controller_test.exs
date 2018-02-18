defmodule EliscoreWeb.UserControllerTest do
  use EliscoreWeb.ConnCase, async: true
  import Eliscore.Factory
  alias Eliscore.{Repo, User}

  test "index/2 responds with all Users" do
    user1 = insert(:user, full_name: "Marco")
    insert(:user, full_name: "Polo")

    response = build_conn()
               |> Eliscore.Guardian.Plug.sign_in(user1)
               |> get(user_path(build_conn(), :index))
               |> json_response(200)

    assert %{
      "data" => [
        %{
          "full_name" => "Marco",
          "image_url" => "image/url",
        },
        %{
          "full_name" => "Polo",
          "image_url" => "image/url",
        }
      ]
    } = response
  end

  describe "show/2" do
    test "responds with one User" do
      user = insert(:user)
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
                 |> Eliscore.Guardian.Plug.sign_in(user)
                 |> get(user_path(build_conn(), :show, user_1))
                 |> json_response(200)

      assert %{
        "data" => %{
          "full_name" => "John Doe",
          "image_url" => "image/url",
          "email" => "test3@test.test"
        }
      } = response
    end

    test "responds with a message User not found " do
      user = insert(:user)
      response = build_conn()
                 |> Eliscore.Guardian.Plug.sign_in(user)
                 |> get(user_path(build_conn(), :show, 300))
                 |> json_response(404)

      expected = %{ "error" => "User not found." }

      assert response == expected
    end
  end
end
