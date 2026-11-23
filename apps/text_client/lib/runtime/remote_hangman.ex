defmodule TextClient.Runtime.RemoteHangman do
  @moduledoc """
  Starts games on a remote hangman node, falling back to a local game when it is unreachable.
  """

  @remote_server :hangman@devpad3

  @doc "Starts a new game on the remote server, or locally when the server cannot be reached."
  def connect() do
    case :rpc.call(@remote_server, Hangman, :newGame, []) do
     
      {:badrpc, _reason} -> 
        Hangman.newGame()

      res -> 
        res

    end
  end
end
