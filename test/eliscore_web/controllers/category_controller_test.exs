defmodule EliscoreWeb.CategoryControllerTest do
  use EliscoreWeb.ConnCase
  import Eliscore.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all categories", %{conn: conn} do
      user = insert(:user)
      conn = conn |> Eliscore.Guardian.Plug.sign_in(user)
      conn = get conn, category_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end
end
