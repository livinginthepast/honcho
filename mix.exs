defmodule Honcho.MixProject do
  use Mix.Project

  def project(),
    do: [
      aliases: aliases(),
      app: :honcho,
      deps: deps(),
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      escript: escript(),
      start_permanent: Mix.env() == :prod,
      version: "0.1.0"
    ]

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application(),
    do: [
      mod: {Honcho.Application, []},
      extra_applications: [:logger]
    ]

  defp deps(),
    do: []

  def escript(),
    do: [
      main_module: Honcho,
      name: "honcho",
      app: nil,
      path: "./bin/honcho"
    ]

  defp aliases(),
    do: [
      test: "test --no-start"
    ]
end
