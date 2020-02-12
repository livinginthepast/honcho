defmodule Honcho.Subcommand.Help do
  @behaviour Honcho.Subcommand

  @impl Honcho.Subcommand
  def run(args \\ [])
  def run(_args), do: Honcho.Output.usage()
end
