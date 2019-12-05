defmodule Honcho.Command do
  defstruct ~w{
    args
    cmd
  }a

  def new([cmd | args]), do: %__MODULE__{cmd: cmd, args: args}
end
