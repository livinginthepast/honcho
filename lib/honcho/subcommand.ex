defmodule Honcho.Subcommand do
  def find("start"), do: {:ok, Honcho.Subcommand.Start}
  def find("info"), do: {:ok, Honcho.Subcommand.Info}
  def find("help"), do: {:ok, Honcho.Subcommand.Help}
  def find("usage"), do: {:ok, Honcho.Subcommand.Help}
  def find(cmd), do: {:error, :no_command, cmd}
end
