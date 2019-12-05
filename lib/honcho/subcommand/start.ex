defmodule Honcho.Subcommand.Start do
  def run() do
    with {:ok, _} <- Application.ensure_all_started(:honcho, :permanent) do
      :timer.sleep(:infinity)
    else
      {:error, _} -> System.stop(1)
    end
  end
end
