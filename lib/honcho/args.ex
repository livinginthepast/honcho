defmodule Honcho.Args do
  @moduledoc false

  def parse(args), do: parse(Keyword.new(), args)
  def parse(argument_list, []), do: {:ok, argument_list}

  def parse(argument_list, ["-p", procfile | tail]),
    do: parse(Keyword.put(argument_list, :procfile, procfile), tail)

  def parse(argument_list, ["--procfile", procfile | tail]),
    do: parse(Keyword.put(argument_list, :procfile, procfile), tail)

  def parse(_argument_list, [key | _]),
    do: {:error, :parse_args, key}
end
