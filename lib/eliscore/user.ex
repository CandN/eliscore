defmodule Eliscore.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]
  alias Eliscore.{Repo, User}
  alias Ueberauth.Auth

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

  @required_fields ~w(login email)
  @optional_fields ~w(encrypted_password admin)

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required([:login, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  def find_or_create(%Auth{} = auth) do
    email = auth.info.email
    user = Repo.one(from u in User, where: u.email == ^email) || auth |> from_auth() |> Repo.insert!()

    {:ok, user}
  end

  defp from_auth(auth) do
    changeset(%User{}, %{
      email: auth.info.email,
      login: auth.info.email,
      password: auth.info.email,
    })
  end
end
