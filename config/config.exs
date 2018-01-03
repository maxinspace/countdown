# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :countdown,
  ecto_repos: [Countdown.Repo]

# Configures the endpoint
config :countdown, CountdownWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vctNhlLPCiONkkBLHtTcXdyegNSeGEfJ7482r5NeSibiX4lR3PLO/alcPJ8sVfY0",
  render_errors: [view: CountdownWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Countdown.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures the auth0
config :auth0_ex,
  domain: System.get_env("AUTH0_DOMAIN"),
  mgmt_client_id: System.get_env("AUTH0_MGMT_CLIENT_ID"),
  mgmt_client_secret: System.get_env("AUTH0_MGMT_CLIENT_SECRET"),
  http_opts: []

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
