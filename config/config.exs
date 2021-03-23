# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ecto3_mnesia_perf,
  ecto_repos: [Ecto3MnesiaPerf.Repo]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n"

config :mnesia,
  dir: 'database/dev'

config :ecto3_mnesia_perf, Ecto3MnesiaPerf.Repo,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
