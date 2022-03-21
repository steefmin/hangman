defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "nothing" do
    assert(1 == 1)
  end

  test "regex" do
    assert Regex.match?(~r/[a-z]/, "a")
    assert Regex.match?(~r/[a-z]/, "b")
    assert Regex.match?(~r/[a-z]/, "c")
    assert Regex.match?(~r/[a-z]/, "d")
    assert !Regex.match?(~r/^[a-z]$/, "dd")
  end
end
