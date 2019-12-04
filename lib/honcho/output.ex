defmodule Honcho.Output do
  alias Honcho.Color

  @colors %{
    error: :red,
    info: :cyan,
    warn: :yellow
  }

  def usage() do
    puts("honcho <cmd>")
    puts()
    puts("commands:")
    puts()
    puts("  start - starts processes defined in Procfile")
  end

  def error(string), do: puts(string, :error)
  def warn(string), do: puts(string, :warn)

  def puts(), do: IO.puts("")
  def puts(string), do: puts(string, :info)
  def puts(string, type), do: (string <> "\n") |> write(type)

  defp write(string, type),
    do: string |> Color.colorize(@colors[type]) |> IO.write()
end
