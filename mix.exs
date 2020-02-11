defmodule Honcho.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project(),
    do: [
      aliases: aliases(),
      app: :honcho,
      deps: deps(),
      description: description(),
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      escript: escript(),
      package: package(),
      source_url: "https://github.com/livinginthepast/honcho",
      start_permanent: Mix.env() == :prod,
      version: @version
    ]

  def application(),
    do: [extra_applications: [:logger]]

  def escript(),
    do: [
      main_module: Honcho,
      name: "honcho",
      app: nil,
      path: "./bin/honcho"
    ]

  defp aliases(),
    do: [
      test: "test --no-start",
      "hex.publish": [
        "git.tags.create",
        "git.tags.push",
        "hex.publish"
      ]
    ]

  defp description(),
    do: "Supervises commands described by a Procfile"

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps(),
    do: [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:honcho_supervisor, "#{@version}", runtime: false}
    ]

  defp package(),
    do: [
      licenses: ["MIT"],
      maintainers: ["Eric Saxby"],
      links: %{github: "https://github.com/livinginthepast/honcho"}
    ]
end
