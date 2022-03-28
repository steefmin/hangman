defmodule AiClientTest do
  use ExUnit.Case
  doctest AiClient

  test "greets the world" do
    assert AiClient.hello() == :world
  end
end
