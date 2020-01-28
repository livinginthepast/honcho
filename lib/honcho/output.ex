defmodule Honcho.Output do
  alias Honcho.Color

  @usage """
  honcho <cmd> [options]

  commands:

    start - starts processes defined in Procfile
    help  - prints usage info
    info  - prints info about the current Procfile

  options:

    --procfile - path to a procfile
  """

  @colors %{
    error: :red,
    info: :cyan,
    warn: :yellow
  }

  def usage(), do: @usage |> puts()

  def error(string), do: puts(string, :error)
  def warn(string), do: puts(string, :warn)

  def puts(), do: IO.puts("")
  def puts(string), do: puts(string, :info)
  def puts(string, type), do: (string <> "\n") |> write(type)

  defp write(string, type),
    do: string |> Color.colorize(@colors[type]) |> IO.write()
end
