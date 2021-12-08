defmodule HonchoSupervisor.MixProject do
  use Mix.Project

  @version "0.2.3"

  def project(),
    do: [
      aliases: aliases(),
      app: :honcho_supervisor,
      deps: deps(),
      description: description(),
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),
      source_url: "https://github.com/livinginthepast/honcho",
      start_permanent: Mix.env() == :prod,
      version: @version
    ]

  def application(),
    do: [
      mod: {HonchoSupervisor.Application, []},
      extra_applications: [:logger]
    ]

  defp aliases(), do: []
  defp elixirc_paths(_), do: ["lib"]
  defp deps(), do: [{:ex_doc, ">= 0.0.0", only: :dev, runtime: false}]
  defp description(), do: "Supervision modules used by honcho"

  defp package(),
    do: [
      licenses: ["MIT"],
      maintainers: ["Eric Saxby"],
      links: %{"GitHub" => "https://github.com/livinginthepast/honcho"}
    ]
end
