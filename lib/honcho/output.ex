defmodule Honcho.Output do
  @moduledoc """
  Provides colorized output.
  """

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

  @doc "Outputs usage information for running Honcho as an escript"
  def usage, do: @usage |> puts()

  @doc "Writes an error message"
  def error(string), do: puts(string, :error)

  @doc "Writes a warning message"
  def warn(string), do: puts(string, :warn)

  def now, do: DateTime.utc_now() |> DateTime.to_iso8601()

  @doc "Writes an info message"
  def puts, do: IO.puts("")
  def puts(string), do: puts(string, :info)
  def puts(string, type), do: (string <> "\n") |> write(type)

  defp write(string, type),
    do: string |> Color.colorize(@colors[type]) |> IO.write()
end
