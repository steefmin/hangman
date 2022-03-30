defmodule TextClient.Runtime.RemoteHangman do

  @remote_server :hangman@devpad3

  def connect() do
    :rpc.call(@remote_server, Hangman, :newGame, [])
  end
end
