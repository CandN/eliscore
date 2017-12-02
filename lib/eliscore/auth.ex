defmodule Eliscore.Auth do
  use EliscoreWeb, :controller
  alias Eliscore.{Repo, User}

  def sign_in_user(conn, params) do
    case find_or_create(params) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = user |> Guardian.encode_and_sign(:token)

        conn
        |> put_status(:ok)
        |> render(EliscoreWeb.SessionView, "show.json", jwt: jwt, user: user)

      {:error, _} ->

        conn
        |> put_status(:bad_request)
        |> render(EliscoreWeb.SessionView, "error.json")
    end
  end

  defp find_or_create(params) do
    params_map = Map.new(params, fn {k, v} -> {String.to_atom(k), v} end)
    case Repo.get_by(User, params_map) do
      nil ->
        User.changeset(%User{}, params_map)
        |> Repo.insert
      user ->
        {:ok, user}
    end
  end
end
