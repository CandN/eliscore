defmodule EliscoreWeb.RegistrationControllerTest do
  use EliscoreWeb.ConnCase, async: true
  alias EliscoreWeb.RegistrationController

  describe "create/2" do
    test "returns jwt and user in response" do
      user_params = %{"user" => %{login: "Test1", email: "t@test.pl", password: "pass"}}
      response = build_conn()
                 |> RegistrationController.create(user_params)
                 |> json_response(200)

      assert Map.has_key?(response, "jwt") == true
      assert Map.has_key?(response, "user") == true
    end

    test "returns error when wrong changeset provided" do
      user_params = %{"user" => %{}}
      response = build_conn()
                 |> RegistrationController.create(user_params)

      assert response.status == 400
      assert Map.has_key?(response.assigns(), :changeset) == true 
    end
  end
end
