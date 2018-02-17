defmodule EliscoreWeb.TokensController do
  use EliscoreWeb, :controller
  alias Eliscore.{Guardian, Repo, User}

  def verify(conn, params) do
    token = params["token"]

    case Guardian.decode_and_verify(token) do
      {:error, _} ->
        conn
          |> put_resp_content_type("application/json")
          |> send_resp(404, "Not found")
          |> halt()
      {:ok, %{"sub" => id}} ->
        case Repo.get(User, id) do
          nil ->
            conn
              |> put_resp_content_type("application/json")
              |> send_resp(404, "Not found")
              |> halt()
          user ->
            conn
              |> render(EliscoreWeb.UserView, "show.json", user: user)
        end
    end
  end
end
