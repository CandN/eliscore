defmodule Eliscore.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eliscore.Chat.{Chatroom, Message}


  schema "messages" do
    field :author_id, :integer
    field :body, :string
    belongs_to :chatroom, Chatroom, foreign_key: :chatroom_id

    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:author_id, :body, :chatroom_id])
    |> validate_required([:author_id, :body, :chatroom_id])
  end
end
