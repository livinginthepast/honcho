defmodule Honcho.MixProject do
  use Mix.Project

  @version "0.2.4"

  def project(),
    do: [
      aliases: aliases(),
      app: :honcho,
      deps: deps(),
      description: description(),
      dialyzer: dialyzer(),
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      escript: escript(),
      package: package(),
      preferred_cli_env: [credo: :test, dialyzer: :test],
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
      test: "test --no-start"
    ]

  defp description(),
    do: "Supervises commands described by a Procfile"

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps(),
    do: [
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:honcho_supervisor, "> 0.0.0", runtime: false},
      {:mix_audit, "~> 2.0", only: [:dev, :test], runtime: false}
    ]

  defp dialyzer do
    [
      plt_add_apps: [:ex_unit, :mix],
      plt_add_deps: :app_tree,
      plt_file: {:no_warn, "priv/plts/#{otp_version()}/dialyzer.plt"}
    ]
  end

  defp package(),
    do: [
      licenses: ["MIT"],
      maintainers: ["Eric Saxby"],
      links: %{github: "https://github.com/livinginthepast/honcho"}
    ]

  defp otp_version do
    Path.join([:code.root_dir(), "releases", :erlang.system_info(:otp_release), "OTP_VERSION"])
    |> File.read!()
    |> String.trim()
  end
end
