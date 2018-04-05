defmodule Eliscore.Chat do
  @moduledoc """
  The Chat context.
  """

  import Ecto.Query, warn: false
  alias Eliscore.Repo

  alias Eliscore.Chat.{Message, Chatroom}

  @doc """
  Gets 10 last chatroom messages based on chatroom_id.
  """
  def find_messages(chatroom_id) do
    query = from m in Message,
      select: %{"id" => m.id, "author_id" => m.author_id, "body" => m.body, "timestamp" => m.inserted_at},
      where: m.chatroom_id == ^chatroom_id,
      order_by: [desc: m.inserted_at],
      limit: 10
    Repo.all(query)
      |> Enum.reverse()
  end

  @doc """
  Creates a message.

  ## Examples

      iex> create_message(%{body: value})
      {:ok, %Message{}}

      iex> create_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets a single chatroom based on members array.
  """
  def find_chatroom(members) do
    Repo.get_by(Chatroom, members: members)
  end

  @doc """
  Gets a single chatroom.

  Raises `Ecto.NoResultsError` if the Chatroom does not exist.

  ## Examples

      iex> get_chatroom!(123)
      %Chatroom{}

      iex> get_chatroom!(456)
      ** (Ecto.NoResultsError)

  """
  def get_chatroom!(id), do: Repo.get!(Chatroom, id)

  @doc """
  Creates a chatroom.

  ## Examples

      iex> create_chatroom(%{field: value})
      {:ok, %Chatroom{}}

      iex> create_chatroom(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_chatroom(attrs \\ %{}) do
    %Chatroom{}
    |> Chatroom.changeset(attrs)
    |> Repo.insert()
  end
end