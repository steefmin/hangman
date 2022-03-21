defmodule GameTest do
  use ExUnit.Case
  alias Hangman.Impl.Game
  doctest Game

  setup do
    [subject: Game.newGame()]
  end

  test "new game state is initializing", context do
    assert context.subject.game_state === :initializing
  end

  test "new game starts with correct amount of turns", context do
    assert context.subject.turns_left === 7
  end

  test "new game starts with no letters used", context do
    assert context.subject.used === MapSet.new()
  end

  test "new game has list with lowercase letters", context do
    assert [_ | _] = context.subject.letters
    context.subject.letters |> Enum.count() |> TestHelper.greaterThan(0)

    context.subject.letters
    |> Enum.each(fn letter ->
      assert (fn letter -> letter =~ ~r/[a-z]/ end).(letter)
    end)
  end

  test "new game creates correct word" do
    subject = Game.newGame("wombat")
    assert subject.letters === ["w", "o", "m", "b", "a", "t"]
  end

  test "game does not change if game is won or lost" do
    for state <- [:won, :lost] do
      game = Game.newGame("wombat")
      game = Map.put(game, :game_state, state)
      {new_game, _tally} = Game.makeMove(game, "x")
      assert new_game === game
    end
  end

  test "make move sets state to already used when guess is already used" do
    game = Game.newGame("wombat")
    game = Map.put(game, :used, MapSet.new(["a"]))
    {new_game, tally} = Game.makeMove(game, "a")
    assert new_game.game_state === :already_used
    assert tally.game_state === :already_used
    assert new_game.used === MapSet.new(["a"])
  end

  test "make move adds new letter" do
    game = Game.newGame("wombat")
    game = Map.put(game, :used, MapSet.new())
    {new_game, _tally} = Game.makeMove(game, "x")
    assert new_game.used === MapSet.new(["x"])
  end

  test "make move adds letters and reports used letters", context do
    game = context.subject
    {game, _tally} = Game.makeMove(game, "x")
    assert game.game_state !== :already_used
    {game, _tally} = Game.makeMove(game, "y")
    assert game.game_state !== :already_used
    {game, tally} = Game.makeMove(game, "x")
    assert game.game_state === :already_used
    assert tally.game_state === :already_used
    assert MapSet.equal?(game.used, MapSet.new(["x", "y"]))
  end
end
