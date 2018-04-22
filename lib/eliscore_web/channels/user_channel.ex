defmodule EliscoreWeb.UserChannel do
  use EliscoreWeb, :channel
  alias EliscoreWeb.Presence

  def join("users:" <> user_id, _params, socket) do
    current_user = socket.assigns.current_user

    if String.to_integer(user_id) == current_user.id do
      {:ok, socket}
    else
      {:error, %{reason: "Invalid user"}}
    end
  end
end
