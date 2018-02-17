defmodule EliscoreWeb.CurrentUserControllerTest do
  use EliscoreWeb.ConnCase, async: true
  import Eliscore.Factory

  describe "show/2" do
    test "responds with current user" do
      user = insert(:user, full_name: "John Doe", email: "t@test.pl")

      conn = build_conn()
        |> Eliscore.Guardian.Plug.sign_in(user)
      jwt = Eliscore.Guardian.Plug.current_token(conn)

      response = conn
        |> put_req_header("authorization", "bearer:" <> jwt)
        |> get(current_user_path(build_conn(), :show))
        |> json_response(200)

      expected = %{
        "data" => %{
          "full_name" => "John Doe",
          "id" => user.id,
          "image_url" => "image/url",
          "email" => "t@test.pl"
        }
      }
      assert response == expected
    end

    test "returns nil when provided with wrong jwt" do
      response = build_conn()
        |> put_req_header("authorization", "bearer:wrong_jwt")
        |> get(current_user_path(build_conn(), :show))

      expected = "unauthenticated"
      assert response.resp_body == expected
    end
  end
end
