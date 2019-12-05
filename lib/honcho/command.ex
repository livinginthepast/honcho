defmodule Honcho.Command do
  use GenServer

  defstruct ~w{
    args
    cmd
  }a

  def new([cmd | args]), do: %__MODULE__{cmd: cmd, args: args}

  def start_link(name: name, command: %__MODULE__{} = command),
    do: GenServer.start_link(__MODULE__, command, name: name)

  def init(command) do
    {:ok, command}
    |> IO.inspect()
  end
end

defimpl String.Chars, for: Honcho.Command do
  def to_string(command) do
    "#{command.cmd} #{Enum.join(command.args, " ")}"
  end
end
