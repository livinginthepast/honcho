defmodule Honcho.Subcommand.Start do
  @moduledoc """
  Starts the processes in a given Procfile.
  """
  @behaviour Honcho.Subcommand

  import Honcho.Output, only: [now: 0]

  @version Mix.Project.config()[:version]
  @default_args [procfile: "Procfile"]

  @impl Honcho.Subcommand
  def run(args \\ @default_args)

  def run([{:procfile, file} | _]) when is_binary(file),
    do: Honcho.Procfile.read(file) |> run()

  def run(args) when is_list(args),
    do: @default_args |> Keyword.merge(args) |> run()

  def run({:ok, commands}),
    do: Honcho.Command.Init.run(commands) |> run()

  def run({:ok, :init, commands}),
    do: Application.put_env(:honcho, :commands, commands) |> run()

  def run(:ok) do
    Honcho.Output.warn("#{now()} [Honcho v#{version()}] ...")

    case Application.ensure_all_started(:honcho_supervisor, :permanent) do
      {:ok, _app} -> :timer.sleep(:infinity)
      {:error, _} -> System.stop(1)
    end
  end

  def run({:error, _} = error), do: Honcho.Error.parse(error)

  defp version, do: @version
end
