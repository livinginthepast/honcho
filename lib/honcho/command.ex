defmodule Honcho.Command do
  @moduledoc false
  use GenServer

  import Honcho.Output, only: [now: 0]
  alias Honcho.Command.Helpers
  alias Honcho.Output

  defstruct ~w{
    args
    cmd
    name
    pid
    port
  }a

  def new(name, [cmd | args]), do: %__MODULE__{cmd: cmd, args: args, name: name}

  def start_link(name: name, command: %__MODULE__{} = command),
    do: GenServer.start_link(__MODULE__, command, name: name)

  ### Callbacks

  def init(%__MODULE__{port: nil} = command) do
    wrapper =
      System.get_env("HOME")
      |> Path.join(".honcho")
      |> Path.join("wrapper")

    Process.flag(:trap_exit, true)

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
    state =
      %{command | pid: Helpers.pid_from(port)}
      |> warn("starting")

    {:ok, state}
  end

  def terminate(_msg, _state) do
    :ok
  end

  def handle_info({_port, {:exit_status, 0}}, state) do
    state |> warn("exited with status 0")
    {:stop, :normal, state}
  end

  def handle_info({_port, {:exit_status, status}}, state) do
    state |> error("exited with status #{status}. Shutting down...")
    System.halt()
    {:noreply, state}
  end

  def handle_info({_port, {:data, msg}}, state) do
    state |> info(msg)
    {:noreply, state}
  end

  def handle_info({:EXIT, _port, :normal}, state) do
    {:stop, :normal, state}
  end

  ### Private

  defp error(state, msg) do
    Output.error("#{now()} [Command:#{state.name}] #{msg}")
    state
  end

  defp info(state, msg) do
    Output.puts("[Command:#{state.name}] #{String.replace_trailing(msg, "\n", "")}")
    state
  end

  defp warn(state, msg) do
    Output.warn("#{now()} [Command:#{state.name}] #{msg}")
    state
  end
end

defimpl String.Chars, for: Honcho.Command do
  def to_string(command) do
    "#{command.cmd} #{Enum.join(command.args, " ")}"
  end
end
