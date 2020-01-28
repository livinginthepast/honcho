defmodule Honcho.Subcommand.Start do
  @default_args [procfile: "Procfile"]

  def run(args \\ @default_args)

  def run([{:procfile, file} | _]) when is_binary(file),
    do: Honcho.Procfile.read(file) |> run()

  def run({:ok, commands}),
    do: Application.put_env(:honcho, :commands, commands) |> run()

  def run(:ok) do
    with {:ok, _app} <- Application.ensure_all_started(:honcho, :permanent) do
      :timer.sleep(:infinity)
    else
      {:error, _} -> System.stop(1)
    end
  end

  def run({:error, _} = error), do: Honcho.Error.parse(error)
end
