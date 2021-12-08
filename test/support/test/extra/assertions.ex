defmodule Honcho.Test.Extra.Assertions do
  @moduledoc false
  import ExUnit.Assertions

  def assert_eq(left, right, opts \\ [])

  def assert_eq(left, right, opts) when is_list(left) and is_list(right) do
    {left, right} =
      if Keyword.get(opts, :ignore_order, false) do
        {Enum.sort(left), Enum.sort(right)}
      else
        {left, right}
      end

    assert left == right
    left
  end

  def assert_eq(string, %Regex{} = regex, _opts) when is_binary(string) do
    unless string =~ regex do
      ExUnit.Assertions.flunk("""
        Expected string to match regex
        left (string): #{string}
        right (regex): #{regex |> inspect}
      """)
    end

    string
  end

  def assert_eq(left, right, _opts) do
    assert left == right
    left
  end

  def assert_matches(left, right) do
    assert left =~ right
  end
end
