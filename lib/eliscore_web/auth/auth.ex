defmodule Eliscore.Auth do
  use EliscoreWeb, :controller
  alias Eliscore.{Repo, User}
  require IEx

  def sign_in_user(conn, params) do
    case find_or_create(params) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = user |> Eliscore.Guardian.encode_and_sign(%{}, token_type: "access")

        conn
        |> Eliscore.Guardian.Plug.sign_in(user)
        |> put_status(:ok)
        |> render(EliscoreWeb.SessionView, "show.json", jwt: jwt, user: user)

      {:error, _} ->

        conn
        |> put_status(:bad_request)
        |> render(EliscoreWeb.SessionView, "error.json")
    end
  end

  defp find_or_create(params) do
    case Repo.get_by(User, params_map(params)) do
      nil ->
        %User{}
        |> User.changeset(params)
        |> Repo.insert
      user ->
        update_user_image(user, params["image_url"])
        {:ok, user}
    end
  end

  defp params_map(params) do
    %{
      email: params["email"],
      uuid: params["uuid"],
    }
  end

  defp update_user_image(user, image_url) do
    user
    |> Ecto.Changeset.change(%{image_url: image_url})
    |> Repo.update
  end
end
