ExUnit.start()

defmodule TestHelper do
  require ExUnit.Assertions
  def same(value, expected) do
    ExUnit.Assertions.assert value === expected
  end

  def greaterThan(value, expected) do
    ExUnit.Assertions.assert value > expected
  end
end
