defmodule TimeApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TimeAppWeb.Telemetry,
      TimeApp.Repo,
      {DNSCluster, query: Application.get_env(:time_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TimeApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TimeApp.Finch},
      # Start a worker by calling: TimeApp.Worker.start_link(arg)
      # {TimeApp.Worker, arg},
      # Start to serve requests, typically the last entry
      TimeAppWeb.Endpoint,
      {Absinthe.Subscription, TimeAppWeb.Endpoint}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TimeApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TimeAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
