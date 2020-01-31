defmodule Honcho.Command do
  use GenServer

  alias Honcho.Command.Helpers

  defstruct ~w{
    args
    cmd
    pid
    port
  }a

  def new([cmd | args]), do: %__MODULE__{cmd: cmd, args: args}

  def start_link(name: name, command: %__MODULE__{} = command),
    do: GenServer.start_link(__MODULE__, command, name: name)

  def init(%__MODULE__{port: nil} = command) do
    wrapper =
      System.get_env("HOME")
      |> Path.join(".honcho")
      |> Path.join("wrapper")

    %{
      command
      | port:
          Port.open({:spawn_executable, wrapper}, [
            :binary,
            :use_stdio,
            :exit_status,
            args: [command.cmd | command.args]
          ])
    }
    |> init()
  end

  def init(%__MODULE__{pid: nil, port: port} = command) do
    {:ok, %{command | pid: Helpers.pid_from(port)}}
    |> IO.inspect(label: "command")
  end
end

defimpl String.Chars, for: Honcho.Command do
  def to_string(command) do
    "#{command.cmd} #{Enum.join(command.args, " ")}"
  end
end
