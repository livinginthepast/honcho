defmodule Honcho.Application do
  use Application

  def start(_type, _args) do
    Honcho.Output.warn("starting…")
    Honcho.CommandSupervisor.start_link()
  end
end
