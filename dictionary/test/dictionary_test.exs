defmodule DictionaryTest do
  use ExUnit.Case
  doctest Dictionary

  test "greets the world" do
    assert Dictionary.words() |> is_list()
    assert Dictionary.randomWord() |> is_binary()
  end
end
