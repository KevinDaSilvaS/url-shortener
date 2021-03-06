defmodule UrlShortener.Application do
  use Application
  require Logger

  def start(_type, _args) do
    import Supervisor.Spec
    children = [
      {Plug.Cowboy, scheme: :http, plug: UrlShortener.Router, options: [port: 8080]},
      worker(Mongo, [[name: :mongo, url: "mongodb://mongo:27017/links", pool_size: 10]])
    ]

    opts = [strategy: :one_for_one, name: UrlShortener.Supervisor]
    Logger.info "Starting application..."
    Supervisor.start_link(children, opts)
  end
end
