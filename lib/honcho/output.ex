defmodule Honcho.Output do
  alias Honcho.Color

  @colors %{
    info: :cyan
  }

  def usage() do
    puts("honcho <cmd>")
    puts()
    puts("commands:")
    puts()
    puts("  start - starts processes defined in Procfile")
  end

  def puts(), do: IO.puts("")
  def puts(string), do: puts(string, :info)
  def puts(string, type), do: (string <> "\n") |> write(type)

  defp write(string, type),
    do: string |> Color.colorize(@colors[type]) |> IO.write()
end
