defmodule Honcho.Subcommand.Start do
  def run(file \\ "Procfile")

  def run(file) when is_binary(file) do
    Honcho.Output.puts("starting…")

    Honcho.Procfile.read(file)
    |> run()
  end

  def run({:ok, commands}), do: IO.inspect(commands)

  def run({:error, :enoent}), do: Honcho.Output.error("Unable to find Procfile")

  def run({:error, :duplicate_services}),
    do: Honcho.Output.error("Duplicate services found in Procfile")

  def run({:error, :malformed_service}),
    do: Honcho.Output.error("Unable to start services: Procfile is malformed")

  def run({:error, :empty_procfile}),
    do: Honcho.Output.error("Unable to start services: Procfile is empty")
end
