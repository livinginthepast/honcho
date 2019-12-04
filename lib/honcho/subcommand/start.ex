defmodule Honcho.Subcommand.Start do
  def run() do
    Honcho.Output.puts("starting…")

    Honcho.Procfile.read()
    |> run()
  end

  defp run({:error, :enoent}), do: Honcho.Output.warn("Unable to find Procfile")
end
