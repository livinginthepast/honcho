defmodule Honcho.Command.Init do
  @moduledoc false

  @wrapper """
  #!/bin/sh

  # Start the program in the background
  exec "$@" &
  pid1=$!

  # Silence warnings from here on
  exec >/dev/null 2>&1

  # Read from stdin in the background and
  # kill running program when stdin closes
  exec 0<&0 $(
    while read; do :; done
    kill -KILL $pid1
  ) &
  pid2=$!

  # Clean up
  wait $pid1
  ret=$?
  kill -KILL $pid2
  exit $ret
  """

  def run(commands) when is_map(commands),
    do: System.fetch_env("HOME") |> run(commands)

  def run(:error),
    do: {:error, :no_home_var}

  def run({:ok, home}, commands) when is_binary(home) do
    path = Path.join(home, ".honcho")
    file = Path.join(path, "wrapper")

    with :ok <- File.mkdir_p(path),
         :ok <- File.write(file, @wrapper, ~w{write }a),
         :ok <- File.chmod(file, 0o755) do
      {:ok, :init, commands}
    else
      {:error, error} ->
        {:error, error, file}
    end
  end
end
