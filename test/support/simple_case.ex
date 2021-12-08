defmodule Honcho.SimpleCase do
  @moduledoc false
  use ExUnit.CaseTemplate

  using do
    quote do
      import ExUnit.Assertions
      import Honcho.Test.Extra.Assertions
    end
  end
end
