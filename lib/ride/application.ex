defmodule Ride.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Ride.Repo,
      # Start the Telemetry supervisor
      RideWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Ride.PubSub},
      # Start the Endpoint (http/https)
      RideWeb.Endpoint
      # Start a worker by calling: Ride.Worker.start_link(arg)
      # {Ride.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ride.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RideWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
