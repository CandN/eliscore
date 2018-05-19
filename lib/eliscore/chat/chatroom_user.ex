defmodule Eliscore.Chat.ChatroomUser do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eliscore.Chat.{Chatroom, ChatroomUser}
  alias Eliscore.User

  schema "chatroom_users" do
    belongs_to :chatroom, Chatroom, foreign_key: :chatroom_id
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(%ChatroomUser{} = chatroom_user, attrs) do
    chatroom_user
    |> cast(attrs, [:user_id, :chatroom_id])
    |> validate_required([:user_id, :chatroom_id])
  end
end
