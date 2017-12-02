defmodule EliscoreWeb.RegistrationControllerTest do
  use EliscoreWeb.ConnCase, async: true
  alias EliscoreWeb.RegistrationController

  describe "create/2" do
    test "returns jwt and user in response" do
      user_params = %{
        "user" => %{
          "full_name" => "John Doe", 
          "first_name" => "John", 
          "last_name" => "Doe", 
          "email" => "t@test.pl", 
          "uuid" => "123456789"
        }
      }

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
    end
  end
end
