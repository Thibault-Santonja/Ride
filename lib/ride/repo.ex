defmodule Ride.Repo do
  use Ecto.Repo,
    otp_app: :ride,
    adapter: Ecto.Adapters.Postgres
end
