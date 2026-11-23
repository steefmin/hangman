defmodule Dictionary do
  @moduledoc """
  Public API for the word dictionary served by `Dictionary.Runtime.Server`.
  """

  @opaque dict :: Dictionary.Runtime.Server.t()

  @doc "Returns a random word from the whole dictionary."
  @spec randomWord() :: String.t()
  defdelegate randomWord(), to: Dictionary.Runtime.Server

  @doc "Returns a random word with the given number of letters."
  @spec randomWord(integer) :: String.t()
  defdelegate randomWord(wordLength), to: Dictionary.Runtime.Server

  @doc "Returns every word in the dictionary."
  @spec words() :: list(String.t())
  defdelegate words(), to: Dictionary.Runtime.Server

  @doc "Returns every word with the given number of letters."
  @spec words(integer) :: list(String.t())
  defdelegate words(wordLength), to: Dictionary.Runtime.Server
end
