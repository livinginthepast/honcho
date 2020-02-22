defmodule Mix.Tasks.Honcho.Tags.Push do
  @moduledoc false

  use Mix.Task

  @shortdoc false
  def run([]) do
    Mix.Shell.IO.cmd(command() |> Enum.join(" "))
  end

  defp command do
    [
      "git",
      "push",
      "origin",
      "--tags"
    ]
  end
end
