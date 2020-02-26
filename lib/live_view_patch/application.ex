defmodule LiveViewPatch.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the endpoint when the application starts
      LiveViewPatchWeb.Endpoint,
      {Phoenix.PubSub, [name: LiveViewPatch.PubSub, adapter: Phoenix.PubSub.PG2]}
      # Starts a worker by calling: LiveViewPatch.Worker.start_link(arg)
      # {LiveViewPatch.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveViewPatch.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LiveViewPatchWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
