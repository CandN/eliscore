defmodule EliscoreWeb.PageControllerTest do
  use EliscoreWeb.ConnCase
  alias Eliscore.{Repo, Tournament}

  test "GET /", %{conn: conn} do
    Tournament.changeset(
      %Tournament{},%{start_date: "2100-01-01 12:00:00"}
    ) |> Repo.insert

    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Eliscore"
  end
end
