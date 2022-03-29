defmodule DictionaryTest do
  use ExUnit.Case
  doctest Dictionary

  test "greets the world" do
    {:ok, pid} = Dictionary.start_link()
    assert pid |> Dictionary.words() |> is_list()
    assert pid |> Dictionary.randomWord() |> is_binary()
  end
end
