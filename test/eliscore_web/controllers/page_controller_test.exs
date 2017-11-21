defmodule EliscoreWeb.PageControllerTest do
  use EliscoreWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Eliscore"
  end
end
