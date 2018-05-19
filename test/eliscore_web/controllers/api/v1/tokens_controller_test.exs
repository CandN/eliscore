defmodule EliscoreWeb.TokensControllerTest do
  use EliscoreWeb.ConnCase, async: true
  import Eliscore.Factory
  require IEx

  describe "verify/2" do
    test "responds with current user" do
      user = insert(:user, full_name: "John Doe", email: "t@test.pl")

      {:ok, jwt, _claims} = Eliscore.Guardian.encode_and_sign(user, %{}, token_type: "access")

      response = build_conn()
        |> get(tokens_path(build_conn(), :verify, [token: jwt]))
        |> json_response(200)

      expected = %{
        "data" => %{
          "full_name" => "John Doe",
          "image_url" => "image/url",
          "id" => user.id,
          "email" => "t@test.pl"
        }
      }
      assert response == expected
    end

    test "responds with forbidden if token is wrong" do
      jwt = "wrong_token"

      response = build_conn()
        |> get(tokens_path(build_conn(), :verify, [token: jwt]))

      expected = "Not found"
      assert response.resp_body == expected
    end
  end
end
