defmodule Honcho.Subcommand.Help do
  def run(args \\ [])
  def run(_args), do: Honcho.Output.usage()
end
