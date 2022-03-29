defmodule Dictionary do

  @opaque dict :: Dictionary.Domain.WordList.t

  @spec start() :: dict
  defdelegate start(), to: Dictionary.Domain.WordList

  @spec start(integer) :: dict
  defdelegate start(wordLength), to: Dictionary.Domain.WordList

  @spec randomWord(dict) :: String.t
  defdelegate randomWord(wordList), to: Dictionary.Domain.WordList

  @spec words(dict) :: list(String.t)
  defdelegate words(dict), to: Dictionary.Domain.WordList
end
