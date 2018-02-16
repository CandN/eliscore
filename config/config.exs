# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :eliscore,
  ecto_repos: [Eliscore.Repo]

# Configures the endpoint
config :eliscore, EliscoreWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "C8sAN1IjdOTHYphf+g2T8QfxAxAc161SxYB/uS0Yb2AtF4wRs4cDxdxhIo37i3aN",
  render_errors: [view: EliscoreWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Eliscore.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :eliscore, Eliscore.Guardian,
  issuer: "Eliscore",
  ttl: { 3, :days },
  verify_issuer: true,
  secret_key: "ajaha"

config :guardian, Guardian.DB,
  repo: Eliscore.Repo,
  schema_name: "guardian_tokens",
  sweep_interval: 60

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
