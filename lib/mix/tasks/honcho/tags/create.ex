defmodule Mix.Tasks.Honcho.Tags.Create do
  @shortdoc false
  @moduledoc false

  use Mix.Task

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

  defp description do
    Mix.Shell.IO.prompt("Please enter a tag message:")
  end

  defp tag do
    {:ok, version} = :application.get_key(:honcho, :vsn)
    "v#{version}"
  end
end
