defmodule AiClientTest do
  use ExUnit.Case
  doctest AiClient

  test "does start" do
    assert AiClient.start() === :ok
  end

  test "can do many" do
    assert AiClient.load(2) === :ok
  end
end
