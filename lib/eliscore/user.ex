defmodule Eliscore.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eliscore.User
  alias Eliscore.Chat.{ChatroomUser, Chatroom}

  @derive {Jason.Encoder, only: [:id, :email, :full_name, :image_url]}
  schema "users" do
    field :admin, :boolean, default: false
    field :email, :string
    field :password, :string, virtual: true
    field :encrypted_password, :string
    field :login, :string
    field :full_name, :string
    field :image_url, :string
    field :first_name, :string
    field :last_name, :string
    field :uuid, :string

    has_many :chatroom_users, ChatroomUser
    has_many :chatrooms, through: [:chatroom_users, :chatroom]

    timestamps()
  end

  @required_fields ~w(email uuid full_name image_url first_name last_name)
  @optional_fields ~w(encrypted_password admin)

  @spec changeset(%User{}, map()) :: Ecto.Changeset.t()
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required([:uuid, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
