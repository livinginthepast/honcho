defmodule Honcho.CommandSupervisor do
  use Supervisor

  alias Honcho.Command

  def start_link() do
    with {:ok, commands} <- find_commands() do
      System.no_halt(true)
      Supervisor.start_link(__MODULE__, commands, name: __MODULE__)
    else
      {:error, _} = err -> Honcho.Error.parse(err)
    end
  end

  #### Callbacks

  def init(commands) do
    commands
    |> children()
    |> Supervisor.init(strategy: :one_for_one)
  end

  #### Private

  defp children(commands) do
    commands
    |> Enum.map(fn {name, command} ->
      %{id: name, start: {Command, :start_link, [[name: name, command: command]]}}
    end)
  end

  defp find_commands(file \\ "Procfile")
  defp find_commands(file) when is_binary(file), do: Honcho.Procfile.read(file)
end
