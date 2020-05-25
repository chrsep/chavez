# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :chavez,
  ecto_repos: [Chavez.Repo]

# Configures the endpoint
config :chavez, ChavezWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Dwa/YOSRmm71XwESEq5nsOPwId7KolEGsu5D7VPQXyZckG2wwP8bHTcxFCd+066N",
  render_errors: [view: ChavezWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Chavez.PubSub,
  live_view: [signing_salt: "ilSKCqF2"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
