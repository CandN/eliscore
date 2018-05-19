defmodule Eliscore.Chat.Chatroom do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eliscore.Chat.{Chatroom, ChatroomUser, Message}
  alias Eliscore.User


  schema "chatrooms" do
    field :name, :string
    field :members, {:array, :integer}

    has_many :messages, Message
    has_many :chatroom_users, ChatroomUser
    has_many :users, through: [:chatroom_users, :user]

    timestamps()
  end

  @doc false
  def changeset(%Chatroom{} = chatroom, attrs) do
    chatroom
    |> cast(attrs, [:name, :members])
    |> validate_required([])
  end
end
