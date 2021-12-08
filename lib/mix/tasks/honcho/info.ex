defmodule Mix.Tasks.Honcho.Info do
  @shortdoc "Provides info about the current Procfile"

  @moduledoc """
  Provides info about the current Procfile.

  By default, it will look for a file named `Procfile` in the
  current directory.

      mix honcho.info
      mix honcho.info -p /path/to/Procfile
      mix honcho.info --procfile /path/to/procfile

  ## Options

    * `-p, --procfile` - indicates a path to a specific file.
  """
  use Mix.Task

  @recursive true

  @impl Mix.Task
  def run(args) when is_list(args) do
    args
    |> Honcho.Args.parse()
    |> run()
  end

  def run({:error, :parse_args, key}),
    do: Honcho.Output.warn("Unknown option: #{key}")

  def run({:ok, args}),
    do: Honcho.Subcommand.Info.run(args)
end
