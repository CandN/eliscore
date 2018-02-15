defmodule EliscoreWeb.Presence do
  use Phoenix.Presence, otp_app: :eliscore, pubsub_server: Eliscore.PubSub
end
