defmodule EliscoreWeb.UsersControllerTest do
  use EliscoreWeb.ConnCase, async: true

  alias Eliscore.{Repo, User}

  test "index/2 responds with all Users" do
    users = [ User.changeset(%User{},%{login: "Test1", email: "test1@test.test", password: "password"}),
              User.changeset(%User{},%{login: "Test2", email: "test2@test.test", password: "password"})]
    Enum.each(users, &Repo.insert!(&1))

    response = build_conn()
               |> get(users_path(build_conn(), :index))
               |> json_response(200)

    expected = [
      %{"login" => "Test1", "email" => "test1@test.test", "id" => 12 },
      %{"login" => "Test2", "email" => "test2@test.test", "id" => 13 }
    ]

    assert response == expected
  end
end
