defmodule Honcho.Subcommand do
  @moduledoc """
  Implements the behaviour that Honcho subcommands must implement.
  """

  @callback run(args :: Keyword.t()) :: term

  @doc false
  def find("start"), do: {:ok, Honcho.Subcommand.Start}
  def find("info"), do: {:ok, Honcho.Subcommand.Info}
  def find("help"), do: {:ok, Honcho.Subcommand.Help}
  def find("usage"), do: {:ok, Honcho.Subcommand.Help}
  def find(cmd), do: {:error, :no_command, cmd}
end
