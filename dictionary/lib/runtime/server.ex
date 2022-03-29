defmodule Dictionary.Runtime.Server do
  alias Dictionary.Domain.WordList

  @type t :: pid

  @spec start_link() :: {atom, t}
  def start_link() do
    Agent.start_link(WordList, :start, [])
  end

  @spec start_link(integer) :: {atom, t}
  def start_link(wordlength) do
    Agent.start_link(WordList, :start, [wordlength])
  end

  @spec randomWord(pid) :: String.t()
  def randomWord(pid) do
    Agent.get(pid, &WordList.randomWord/1)
  end

  @spec words(pid) :: list(String.t())
  def words(pid) do
    Agent.get(pid, &WordList.words/1)
  end
end
