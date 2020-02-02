defmodule Mix.Tasks.Git.Tags.Create do
  @moduledoc false

  use Mix.Task

  @shortdoc "Creates a git tag"
  def run([]) do
    Mix.Task.run("app.start", [])

    Mix.Shell.IO.cmd(
      command()
      |> Enum.join(" ")
    )
  end

  defp command do
    [
      "git",
      "tag",
      "-a",
      tag(),
      "-m",
      "'#{description()}'"
    ]
  end

  defp description() do
    Mix.Shell.IO.prompt("Please enter a tag message:")
  end

  defp tag() do
    {:ok, version} = :application.get_key(:honcho, :vsn)
    "v#{version}"
  end
end
