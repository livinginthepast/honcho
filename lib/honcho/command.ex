defmodule Honcho.Command do
  def find("start"), do: Honcho.Command.Start
  def find(_), do: nil
end
