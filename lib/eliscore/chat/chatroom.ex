defmodule Eliscore.Chat.Chatroom do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eliscore.Chat.{Chatroom, Message}


  schema "chatrooms" do
    field :name, :string
    has_many :messages, Message

    timestamps()
  end

  @doc false
  def changeset(%Chatroom{} = chatroom, attrs) do
    chatroom
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
