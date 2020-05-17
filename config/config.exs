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
  secret_key_base: "4bkuIYW17av5dKJ9HcRd1wEohfMFjcszP8auXbyA13RmkhgfEZzcppNJUoO8N3IU",
  render_errors: [view: ChavezWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Chavez.PubSub, adapter: Phoenix.PubSub.PG2],
  cache_static_manifest: "priv/static/cache_manifest.json",
  version: Application.spec(:chavez, :vsn)

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
