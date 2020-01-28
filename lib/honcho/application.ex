defmodule Honcho.Application do
  use Application

  def start(_type, _args) do
    Honcho.Output.warn("starting…")

    Application.get_env(:honcho, :commands)
    |> Honcho.CommandSupervisor.start_link()
  end
end
