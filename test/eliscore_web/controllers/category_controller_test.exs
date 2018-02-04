defmodule EliscoreWeb.CategoryControllerTest do
  use EliscoreWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all categories", %{conn: conn} do
      conn = get conn, category_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end
end
