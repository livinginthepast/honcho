defmodule Mix.Tasks.Honcho.Start do
  use Mix.Task

  @shortdoc "Provides info about the current Procfile"
  @recursive true

  @moduledoc """
  Starts processes defined in a Procfile.

  By default, it will look for a file named `Procfile` in the
  current directory.

      mix honcho.start
      mix honcho.start -p /path/to/Procfile
      mix honcho.start --procfile /path/to/procfile

  ## Options

    * `-p, --procfile` - indicates a path to a specific file.
  """

  @impl Mix.Task
  def run(args) when is_list(args) do
    args
    |> Honcho.Args.parse()
    |> run()
  end

  def run({:error, :parse_args, key}),
    do: Honcho.Output.warn("Unknown option: #{key}")

  def run({:ok, args}),
    do: Honcho.Subcommand.Start.run(args)
end
