defmodule Eliscore.UserFactory do
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %Eliscore.User{
          admin: false,
          email: sequence(:email, &"email-#{&1}@example.com"),
          password: "password",
          login: sequence(:login, &"Login#{&1}")
        }
      end
    end
  end
end
