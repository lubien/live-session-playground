defmodule SessionPlayground.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SessionPlaygroundWeb.Telemetry,
      # Start the Ecto repository
      SessionPlayground.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: SessionPlayground.PubSub},
      # Start Finch
      {Finch, name: SessionPlayground.Finch},
      # Start the Endpoint (http/https)
      SessionPlaygroundWeb.Endpoint
      # Start a worker by calling: SessionPlayground.Worker.start_link(arg)
      # {SessionPlayground.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SessionPlayground.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SessionPlaygroundWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
