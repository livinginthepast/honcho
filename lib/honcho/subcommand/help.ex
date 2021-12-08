defmodule Honcho.Subcommand.Help do
  @moduledoc "Output help info"
  @behaviour Honcho.Subcommand

  @impl Honcho.Subcommand
  def run(args \\ [])
  def run(_args), do: Honcho.Output.usage()
end
