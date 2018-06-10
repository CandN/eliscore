defmodule EliscoreWeb.API.Core do
  use Maru.Router

  @moduledoc """
  This module is responsible for setting the newest version of api
  """

  mount EliscoreWeb.API.V1.Base

  ## >>> 400
  rescue_from Maru.Exceptions.InvalidFormat do
    json(conn, %{status: 400, error: "Invalid Format"})
  end

  ## >>> 404
  rescue_from Maru.Exceptions.NotFound do
    json(conn, %{status: 404, error: "Resource not found"})
  end

  ## >>> 500
  @internal_request_failed "An internal request failed, please try again."
  rescue_from :all do
    json(conn, %{error: @internal_request_failed})
  end
end
