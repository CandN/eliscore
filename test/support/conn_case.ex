defmodule EliscoreWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common datastructures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate
  alias Eliscore.{Repo, User}

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import EliscoreWeb.Router.Helpers

      # The default endpoint for testing
      @endpoint EliscoreWeb.Endpoint

      def sign_in() do
        { :ok, user } = User.changeset(%User{}, %{
          full_name: "John Doe", 
          first_name: "John", 
          last_name: "Doe", 
          image_url: "some/url",
          email: "t@test.pl", 
          uuid: "1234567890"
        }) |> Repo.insert

        {:ok, jwt, _full_claims} = user |> Guardian.encode_and_sign(:token)
        {user, jwt}
      end
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Eliscore.Repo)
    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Eliscore.Repo, {:shared, self()})
    end
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

end
