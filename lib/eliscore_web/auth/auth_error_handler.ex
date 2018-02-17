defmodule Eliscore.Guardian.AuthErrorHandler do
  import Plug.Conn
  require IEx

  def auth_error(conn, {type, reason}, _opts) do
    send_resp(conn, 401, to_string(reason))
  end
end
