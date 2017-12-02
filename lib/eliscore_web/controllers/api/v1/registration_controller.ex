defmodule EliscoreWeb.RegistrationController do
  use EliscoreWeb, :controller

  alias Eliscore.Auth

  plug :scrub_params, "user" when action in [:create]
  def create(conn, %{"user" => user_params}) do
    Auth.sign_in_user(conn, user_params)
  end
end
