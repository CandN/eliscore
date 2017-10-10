defmodule EliscoreWeb.RegistrationController do
  use EliscoreWeb, :controller 

  alias Eliscore.{Repo, User}

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = user |> Guardian.encode_and_sign(:token)

        conn
        |> put_status(:ok)
        |> render(EliscoreWeb.SessionView, "show.json", jwt: jwt, user: user)

      {:error, changeset} ->
        conn
        |> put_status(:error)
        |> render(EliscoreWeb.SessionView, "error.json", changset: changeset)
    end
  end
  
end
