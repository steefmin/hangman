defmodule Dictionary do
  @opaque dict :: Dictionary.Runtime.Server.t()

  @spec randomWord() :: String.t()
  defdelegate randomWord(), to: Dictionary.Runtime.Server

  @spec randomWord(integer) :: String.t()
  defdelegate randomWord(wordLength), to: Dictionary.Runtime.Server

  @spec words() :: list(String.t())
  defdelegate words(), to: Dictionary.Runtime.Server

  @spec words(integer) :: list(String.t())
  defdelegate words(wordLength), to: Dictionary.Runtime.Server
end
