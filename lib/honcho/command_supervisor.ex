defmodule Honcho.CommandSupervisor do
  use Supervisor

  alias Honcho.Command

  def start_link(commands) do
    System.no_halt(true)
    Supervisor.start_link(__MODULE__, commands, name: __MODULE__)
  end

  #### Callbacks

  def init(commands),
    do:
      commands
      |> children()
      |> Supervisor.init(strategy: :one_for_one)

  #### Private

  defp children(commands),
    do: commands |> Enum.map(&child/1)

  defp child({name, command}),
    do: %{id: name, start: {Command, :start_link, [[name: name, command: command]]}}
end
