defmodule Honcho.Command.Helpers do
  @moduledoc false

  def pid_from([{:os_pid, pid} | _tail]), do: pid
  def pid_from([_head | tail]), do: pid_from(tail)
  def pid_from(port) when is_port(port), do: port |> Port.info() |> pid_from()

  def kill(pid, signal \\ "SIGTERM") do
    case System.cmd("ps", [to_string(pid)]) do
      {_, 0} -> System.cmd("kill", ["-#{signal}", to_string(pid)], stderr_to_stdout: true)
      {_, _} -> nil
    end
  end
end
