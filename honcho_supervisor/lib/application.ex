defmodule HonchoSupervisor.Application do
  use Application

  def start(_type, _args) do
    Application.get_env(:honcho, :commands)
    |> HonchoSupervisor.CommandSupervisor.start_link()
  end
end
