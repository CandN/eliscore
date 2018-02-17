defmodule Eliscore.UserFactory do
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %Eliscore.User{
          admin: false,
          email: sequence(:email, &"email-#{&1}@example.com"),
          full_name: sequence(:full_name, &"User#{&1}"),
          login: sequence(:login, &"Login#{&1}"),
          uuid: sequence(:uuid, &"uuid#{&1}"),
          image_url: "image/url"
        }
      end
    end
  end
end
