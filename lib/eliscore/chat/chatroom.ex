defmodule Eliscore.Chat.Chatroom do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eliscore.Chat.{Chatroom, ChatroomUser, Message}
  alias Eliscore.User


  schema "chatrooms" do
    field :name, :string
    has_many :messages, Message
    has_many :chatroom_users, ChatroomUser
    has_many :users, through: [:chatroom_users, :user]

    timestamps()
  end

  @doc false
  def changeset(%Chatroom{} = chatroom, attrs) do
    chatroom
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
