defmodule EliscoreWeb.API.V1.Registrations.Create do
  use Maru.Router
  alias Eliscore.Auth

  @moduledoc """
  This module is responsible for making create registrations endpoint
  """

  params do
    requires :uuid
    requires :email
    optional :password, type: String
    optional :login, type: String
    optional :full_name, type: String
    optional :first_name, type: String
    optional :last_name, type: String
    optional :image_url, type: String
  end

  post do
    Auth.sign_in_user(conn, params)
  end
end
