defmodule Honcho do
  @moduledoc """
  Entry point for Honcho
  """

  def main([]) do
    Honcho.Output.usage()
  end

  def main([cmd | args]) do
    cmd
    |> Honcho.Subcommand.find()
    |> run(args)
  end

  def run(nil, _), do: Honcho.Output.usage()
  def run(cmd, args), do: apply(cmd, :run, args)
end
