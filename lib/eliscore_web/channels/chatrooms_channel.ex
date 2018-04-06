defmodule EliscoreWeb.ChatroomsChannel do
  use EliscoreWeb, :channel
  alias EliscoreWeb.Presence
  alias Eliscore.Chat.Chat

  def join("chatrooms:lobby", _payload, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def join("chatrooms:" <> chatroom_id, payload, socket) do
    messages = Chat.find_messages(chatroom_id)
    {:ok, %{messages: messages}, socket}
  end

  def handle_in("chatrooms:open", payload, socket) do
    members = "name"#payload["body"]
    case Chat.find_chatroom(members) do
      nil ->
        chatroom = Chat.create_chatroom(%{name: members})
        {:reply, {:ok, %{id: chatroom.id }}, socket }
      chatroom ->
        {:reply, {:ok, %{id: chatroom.id }}, socket }
      end
  end

  def handle_in("new_message", %{"body" => body}, socket) do
    current_user = socket.assigns.current_user
    "chatrooms:" <> chatroom_id = socket.topic
    {:ok, message} = Chat.create_message(%{
                        author_id: current_user.id,
                        body: body,
                        chatroom_id: String.to_integer(chatroom_id)
                      })
    broadcast!(socket, "new_message", %{
                body: body,
                id: message.id,
                author_id: message.author_id,
                timestamp: message.inserted_at
               })
             #chatroom = Chat.get_chatroom!(chatroom_id)
    #members = chatroom.members -- [current_user.id]
    #Enum.map(members, fn member_id ->
      #  EliscoreChatWeb.Endpoint.broadcast("users:#{member_id}", "open_room", %{
                                            #                                   chatroom_id: chatroom_id,
                                            # user_id: current_user.id
                                            #})
                                        #end)
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    {:ok, _} = Presence.track(socket, socket.assigns.current_user.id, %{
      id: socket.assigns.current_user.id,
      full_name: socket.assigns.current_user.full_name,
      online_at: inspect(System.system_time(:seconds))
    })
    push(socket, "presence_state", Presence.list(socket))
    broadcast!(socket, "presence_state", Presence.list(socket))
    {:noreply, socket}
  end
end
