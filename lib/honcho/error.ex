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

  def puts({:error, :no_home_var}),
    do: Honcho.Output.error("Unable to read HOME from environment")

  def puts({:error, error, path})
      when is_atom(error) and is_binary(path),
      do: Honcho.Output.error("Received '#{inspect(error)}' when attempting to write '#{path}'")
end
