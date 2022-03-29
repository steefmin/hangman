defmodule Dictionary.Runtime.Server do
  alias Dictionary.Domain.WordList

  @type t :: pid

  @spec start_link() :: {atom, t}
  def start_link() do
    Agent.start_link(WordList, :start, [], name: __MODULE__)
  end

  @spec start_link(integer) :: {atom, t}
  def start_link(wordlength) do
    Agent.start_link(WordList, :start, [wordlength], [{:name, buildAgentName(wordlength) }])
  end

  @spec randomWord() :: String.t()
  def randomWord() do
    Agent.get(__MODULE__, &WordList.randomWord/1)
  end

  @spec randomWord(integer) :: String.t()
  def randomWord(wordLength) do
    Agent.get(buildAgentName(wordLength), &WordList.randomWord/1)
  end

  @spec words() :: list(String.t())
  def words() do
    Agent.get(__MODULE__, &WordList.words/1)
  end

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
