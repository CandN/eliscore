defmodule Eliscore.Guardian.AuthErrorHandler do
  import Plug.Conn

  def auth_error(conn, {_type, reason}, _opts) do
    send_resp(conn, 401, to_string(reason))
  end
end
