defmodule HonchoSupervisor.MixProject do
  use Mix.Project

  def project(),
    do: [
      aliases: aliases(),
      app: :honcho_supervisor,
      deps: deps(),
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      version: "0.1.0"
    ]

  def application(),
    do: [
      mod: {HonchoSupervisor.Application, []},
      extra_applications: [:logger]
    ]

  defp aliases(), do: []
  defp elixirc_paths(_), do: ["lib"]
  defp deps(), do: []
end
