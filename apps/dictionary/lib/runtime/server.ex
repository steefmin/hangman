defmodule Dictionary.Runtime.Server do
  @moduledoc """
  Agent-backed server holding the word lists, one agent per word length.
  """

  alias Dictionary.Domain.WordList

  use Agent

  @type t :: pid

  @doc "Starts the agent serving the whole word list, or only words of a given length."
  @spec start_link(list(integer)) :: Agent.on_start
  def start_link([wordLength]) do
    Agent.start_link(WordList, :start, [wordLength], [{:name, buildAgentName(wordLength)}])
  end

  def start_link(_) do
    Agent.start_link(WordList, :start, [], name: __MODULE__)
  end

  @doc "Returns a random word from the whole word list."
  @spec randomWord() :: String.t()
  def randomWord() do
    Agent.get(__MODULE__, &WordList.randomWord/1)
  end

  @doc "Returns a random word of the given length."
  @spec randomWord(integer) :: String.t()
  def randomWord(wordLength) do
    Agent.get(buildAgentName(wordLength), &WordList.randomWord/1)
  end

  @doc "Returns every word in the whole word list."
  @spec words() :: list(String.t())
  def words() do
    Agent.get(__MODULE__, &WordList.words/1)
  end

  @doc "Returns every word of the given length."
  @spec words(integer) :: list(String.t())
  def words(wordLength) do
    Agent.get(buildAgentName(wordLength), &WordList.words/1)
  end

  defp buildAgentName(wordLength) do
    moduleName = __MODULE__ |> to_string()
    numberOfLetters = wordLength |> to_string() |> String.pad_leading(2, "0")
    "#{moduleName}.forWordsWith#{numberOfLetters}Letters" |> String.to_atom()
  end
end
