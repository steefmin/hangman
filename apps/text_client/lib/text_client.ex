defmodule TextClient do
  @moduledoc """
  Terminal client that plays a game of hangman against a hangman server.
  """

  @doc "Starts a hangman game and plays it interactively in the terminal."
  @spec start() :: :ok
  def start() do
    TextClient.Runtime.RemoteHangman.connect()
    |> TextClient.Impl.Player.start()
  end
end
