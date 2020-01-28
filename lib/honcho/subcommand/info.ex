defmodule Honcho.Subcommand.Info do
  @default_args [procfile: "Procfile"]

  def run(args \\ @default_args)

  def run([{:procfile, file} | _]) when is_binary(file),
    do: Honcho.Procfile.read(file) |> run()

  def run(args) when is_list(args),
    do: @default_args |> Keyword.merge(args) |> run()

  def run({:ok, commands}),
    do: commands |> Enum.each(&info/1)

  def run({:error, _} = error), do: error |> Honcho.Error.parse()

  def info({name, command}),
    do: Honcho.Output.puts("#{name}: #{command}")
end
