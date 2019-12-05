defmodule Honcho do
  @moduledoc """
  Entry point for Honcho
  """

  def main([]) do
    Honcho.Output.usage()
  end

  def main([cmd | args]) do
    System.put_env("ERL_CRASH_DUMP_SECONDS", "0")

    cmd
    |> Honcho.Subcommand.find()
    |> run(args)
  end

  def run({:ok, cmd}, args), do: apply(cmd, :run, args)

  def run({:error, :no_command, cmd}, _) do
    Honcho.Output.warn("Unable to find subcommand #{inspect(cmd)}")
    Honcho.Output.usage()
  end
end
