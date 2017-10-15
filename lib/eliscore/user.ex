defmodule Eliscore.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eliscore.User

  schema "users" do
    field :admin, :boolean, default: false
    field :email, :string
    field :password, :string, virtual: true
    field :encrypted_password, :string
    field :login, :string

    timestamps()
  end

  @required_fields ~w(login email password)
  @optional_fields ~w(encrypted_password admin)

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required([:login, :email,:password])
    |> validate_format(:email, ~r/@/)
    |> generate_encrypted_password 
  end

  defp generate_encrypted_password(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(current_changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        current_changeset 
    end
  end
end
