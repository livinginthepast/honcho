defmodule Honcho do
  @moduledoc """
  Entry point for Honcho
  """

  def main([]), do: Honcho.Output.usage()

  def main([cmd | args]) do
    System.put_env("ERL_CRASH_DUMP_SECONDS", "0")

    cmd
    |> Honcho.Subcommand.find()
    |> run(parse_args(args))
  end

  def run({:ok, cmd}, args), do: apply(cmd, :run, args)

  def run({:error, :no_command, cmd}, _),
    do: usage("Unable to find subcommand #{inspect(cmd)}")

  defp usage(msg) do
    Honcho.Output.warn(msg)
    Honcho.Output.usage()
  end

  defp parse_args(args), do: parse_args(Keyword.new(), args)
  defp parse_args(argument_list, []), do: argument_list

  defp parse_args(argument_list, ["--procfile", procfile | tail]),
    do: parse_args([Keyword.put(argument_list, :procfile, procfile)], tail)

  defp parse_args(_argument_list, [key, value | _]),
    do: usage("Unknown option: #{key} - #{value}")
end
