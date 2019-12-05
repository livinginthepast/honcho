defmodule Honcho.Subcommand.Help do
  def run(), do: Honcho.Output.usage()
end
