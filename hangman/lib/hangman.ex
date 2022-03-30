defmodule Hangman do
  alias Hangman.Runtime.Server
  alias Hangman.Type

  @opaque game :: Server.t()

  @spec newGame() :: game
  defdelegate newGame(), to: Server, as: :start_link

  @spec newGame(integer) :: game
  defdelegate newGame(difficulty), to: Server, as: :start_link

  @spec makeMove(game, String.t()) :: {game, Type.tally}
  defdelegate makeMove(game, guess), to: Server

  @spec tally(game) :: Type.tally
  defdelegate tally(game), to: Server
end
