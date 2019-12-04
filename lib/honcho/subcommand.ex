defmodule Honcho.Subcommand do
  def find("start"), do: Honcho.Subcommand.Start
  def find(_), do: nil
end
