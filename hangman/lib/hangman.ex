defmodule Hangman do
  alias Hangman.Impl.Game
  alias Hangman.Type

  @opaque game :: Game.t()

  @spec newGame() :: game
  defdelegate newGame(), to: Game

  @spec newGame(integer) :: game
  defdelegate newGame(difficulty), to: Game

  @spec makeMove(game, String.t()) :: {game, Type.tally}
  defdelegate makeMove(game, guess), to: Game

  @spec tally(game) :: Type.tally
  defdelegate tally(game), to: Game
end
