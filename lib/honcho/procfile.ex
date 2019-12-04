defmodule Honcho.Procfile do
  alias Honcho.Command

  def read(file) do
    File.read(file)
    |> parse()
  catch
    {:error, _} = error -> error
  end

  defp parse({:ok, lines}), do: lines |> String.split("\n") |> parse(%{})
  defp parse({:error, _} = error), do: error
  defp parse([], commands) when commands == %{}, do: {:error, :empty_procfile}
  defp parse([], commands), do: {:ok, commands}
  defp parse([line | tail], commands), do: parse(tail, line |> parse_line() |> merge(commands))

  defp parse_line(line),
    do: line |> String.split(": ") |> Enum.map(&String.trim/1) |> parse_command()

  defp parse_command([name, command]) when byte_size(command) > 0,
    do: {name, command |> String.split(~r{\s+})}

  defp parse_command([""]), do: nil
  defp parse_command(_), do: throw({:error, :malformed_service})

  defp merge(nil, commands), do: commands

  defp merge({name, command}, commands) do
    commands
    |> Map.has_key?(name)
    |> case do
      true -> throw({:error, :duplicate_services})
      false -> commands |> Map.put(name, Command.new(command))
    end
  end
end
