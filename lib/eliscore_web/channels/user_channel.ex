defmodule EliscoreWeb.UserChannel do
  use EliscoreWeb, :channel
  alias EliscoreWeb.Presence
  require IEx

  def join("users:" <> user_id, _params, socket) do
    current_user = socket.assigns.current_user

    if String.to_integer(user_id) == current_user.id do
      {:ok, socket}
    else
      {:error, %{reason: "Invalid user"}}
    end
  end

  def join("chat", _params, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def join("rooms:" <> user_id, params, socket) do
    {:ok, socket}
  end

  def handle_in("new_message", %{"body" => body}, socket) do
    current_user = socket.assigns.current_user
    broadcast!(socket, "new_message", %{
               body: body,
               author: current_user.full_name,
               timestamp: inspect(System.system_time(:seconds)) })
    {:noreply, socket}
  end

  def terminate(reason, socket) do
    Presence.untrack(socket, socket.assigns.current_user.full_name)
    push(socket, "presence_state", Presence.list(socket))
    broadcast!(socket, "presence_state", Presence.list(socket))
    broadcast!(socket, "asd", Presence.list(socket))
    socket
  end

  def handle_info(:after_join, socket) do
    push(socket, "presence_state", Presence.list(socket))
    broadcast!(socket, "presence_state", Presence.list(socket))
    {:ok, _} = Presence.track(socket, socket.assigns.current_user.full_name, %{
      online_at: inspect(System.system_time(:seconds))
    })
    {:noreply, socket}
  end

  def handle_in("userslist", _params, socket) do
    current_user = socket.assigns.current_user

    if current_user do
      broadcast!(socket, "userslist", %{users: "hi"})
    end
    {:noreply, socket}
  end
end
