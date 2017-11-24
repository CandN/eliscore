defmodule Eliscore.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]
  alias Eliscore.{Repo, User}

  @derive {Poison.Encoder, only: [:id, :email, :login]}
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

    timestamps()
  end

  @required_fields ~w(email uuid)
  @optional_fields ~w(encrypted_password admin full_name image_url first_name last_name)

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required([:uuid, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
