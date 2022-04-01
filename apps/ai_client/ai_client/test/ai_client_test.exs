defmodule AiClientTest do
  use ExUnit.Case
  doctest AiClient

  test "does start" do
    assert AiClient.start() === :ok
    assert AiClient.start(5) === :ok
    assert AiClient.start(10) === :ok
  end

  test "can do many" do
    assert AiClient.load(2) === :ok
    assert AiClient.load(40, 0) === :ok
  end
end
