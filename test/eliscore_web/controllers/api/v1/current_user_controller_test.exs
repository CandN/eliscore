defmodule EliscoreWeb.CurrentUserControllerTest do
  use EliscoreWeb.ConnCase, async: true

  describe "show/2" do
    test "responds with current user" do
      {user, jwt} = sign_in()

      response = build_conn()
      |> put_req_header("authorization", jwt)
      |> get(current_user_path(build_conn(), :show))
      |> json_response(200)

      expected = %{
        "data" => %{
          "full_name" => "John Doe",
          "id" => user.id,
          "image_url" => "some/url",
          "email" => "t@test.pl"
        }
      }
      assert response == expected
    end

    test "returns nil when provided with wrong jwt" do
      %Plug.Conn{assigns: %{error: error}} =
        build_conn()
        |> put_req_header("authorization", "wrong_jwt")
        |> get(current_user_path(build_conn(), :show))

      response = error
      expected = "Wrong token provided"
      assert response == expected
    end

  end
end
