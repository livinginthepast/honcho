defmodule Honcho.Subcommand.Info do
  def run(file \\ "Procfile")

  def run(file) when is_binary(file) do
    Honcho.Procfile.read(file)
    |> run()
  end

  def run({:ok, commands}) do
    commands
    |> Enum.each(fn {name, command} ->
      Honcho.Output.puts("#{name}: #{command}")
    end)
  end

  def run({:error, _} = error), do: error |> Honcho.Error.parse()
end
