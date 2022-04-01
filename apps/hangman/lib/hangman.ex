defmodule Hangman do
  alias Hangman.Runtime.Server
  alias Hangman.Type

  @opaque game :: Server.t()

  @spec newGame() :: game
  def newGame() do
    {:ok, pid} = Hangman.Runtime.Application.startGame(nil)
    pid
  end

  @spec newGame(integer) :: game
  def newGame(difficulty) do
    {:ok, pid} = Hangman.Runtime.Application.startGame(difficulty)
    pid
  end

  @spec makeMove(game, String.t()) :: Type.tally
  def makeMove(game, guess) do
    Server.makeMove(game, guess)
  end

  @spec tally(game) :: Type.tally
  def tally(game) do
    Server.tally(game)
  end
end
