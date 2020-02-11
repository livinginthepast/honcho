defmodule Honcho do
  @moduledoc """
  Entry point for Honcho
  """

  def main([]), do: Honcho.Output.usage()

  def main([cmd | args]) do
    System.put_env("ERL_CRASH_DUMP_SECONDS", "0")

    cmd
    |> Honcho.Subcommand.find()
    |> run(Honcho.Args.parse(args))
  end

  def run(_, {:error, :parse_args, arg}),
    do: usage("Unknown option: #{arg}")

  def run({:ok, cmd}, {:ok, args}), do: apply(cmd, :run, args)

  def run({:error, :no_command, cmd}, _),
    do: usage("Unable to find subcommand #{inspect(cmd)}")

  defp usage(msg) do
    Honcho.Output.warn(msg)
    Honcho.Output.usage()
  end
end
