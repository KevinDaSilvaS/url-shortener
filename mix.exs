defmodule UrlShortener.MixProject do
  use Mix.Project

  def project do
    [
      app: :url_shortener,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {UrlShortener.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.2"},
      {:mongodb, ">= 0.0.0"},
      {:poolboy, ">= 0.0.0"}
    ]
  end
end
