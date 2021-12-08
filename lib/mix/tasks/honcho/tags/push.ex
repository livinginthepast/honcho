defmodule Mix.Tasks.Honcho.Tags.Push do
  @shortdoc false
  @moduledoc false

  use Mix.Task

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
