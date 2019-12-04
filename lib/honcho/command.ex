defmodule Honcho.Command do
  defstruct ~w{
    cmd args
  }a

  def new([cmd | args]), do: %__MODULE__{cmd: cmd, args: args}
end
