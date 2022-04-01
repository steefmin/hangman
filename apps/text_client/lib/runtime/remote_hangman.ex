defmodule TextClient.Runtime.RemoteHangman do

  @remote_server :hangman@devpad3


  def connect() do
    case :rpc.call(@remote_server, Hangman, :newGame, []) do
     
      {:badrpc, _reason} -> 
        Hangman.newGame()

      res -> 
        res

    end
  end
end
