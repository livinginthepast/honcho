defmodule Honcho.SimpleCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Honcho.Test.Extra.Assertions
      import ExUnit.Assertions
    end
  end
end
