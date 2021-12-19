import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ride, Ride.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "ride_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ride, RideWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "tb390OF8/L6D3O1kh6eA8dmmlXjwG48OkT6G1Svf0wd+vAO/sUA/a2YwxFa9jx/t",
  server: false

# In test we don't send emails.
config :ride, Ride.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
