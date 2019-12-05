defmodule Honcho.Error do
  def parse(error) do
    puts(error)
    error
  end

  def puts({:error, :enoent}), do: Honcho.Output.error("Unable to find Procfile")

  def puts({:error, :duplicate_services}),
    do: Honcho.Output.error("Duplicate services found in Procfile")

  def puts({:error, :malformed_service}),
    do: Honcho.Output.error("Unable to start services: Procfile is malformed")

  def puts({:error, :empty_procfile}),
    do: Honcho.Output.error("Unable to start services: Procfile is empty")
end
