defmodule Dictionary do
  @opaque dict :: Dictionary.Runtime.Server.t()

  @spec start_link() :: {atom, dict}
  defdelegate start_link(), to: Dictionary.Runtime.Server

  @spec start_link(integer) :: {atom, dict}
  defdelegate start_link(wordLength), to: Dictionary.Runtime.Server

  @spec randomWord(dict) :: String.t()
  defdelegate randomWord(wordList), to: Dictionary.Runtime.Server

  @spec words(dict) :: list(String.t())
  defdelegate words(dict), to: Dictionary.Runtime.Server
end
