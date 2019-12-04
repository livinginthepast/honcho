defmodule Honcho.Procfile do
  def read() do
    "Procfile"
    |> read()
  end

  def read(file) do
    File.read(file)
    |> parse()
  catch
    {:error, _} = error -> error
  end

  defp parse({:ok, ""}), do: {:error, :empty_procfile}
  defp parse({:ok, lines}), do: lines |> String.split("\n") |> parse(%{})
  defp parse({:error, _} = error), do: error
  defp parse([], commands), do: {:ok, commands}
  defp parse([line | tail], commands), do: parse(tail, line |> parse_line() |> merge(commands))

  defp parse_line(line),
    do: line |> String.split(": ") |> Enum.map(&String.trim/1) |> parse_command()

  defp parse_command([_name, ""]), do: throw({:error, :malformed_service})
  defp parse_command([name, command]), do: {name, command |> String.split(~r{\s+})}
  defp parse_command(_), do: throw({:error, :malformed_service})

  defp merge({name, command}, commands) do
    commands
    |> Map.has_key?(name)
    |> case do
      true -> throw({:error, :duplicate_services})
      false -> commands |> Map.put(name, command)
    end
  end
end
