defmodule Dictionary.Domain.WordList do
  @moduledoc """
  Reads the word list from disk and selects words from it.
  """

  @type t :: list(String.t)

  @doc "Reads the word list from disk."
  @spec start() :: t
  def start() do
    "/home/steef/development/codestool/hangman_game/apps/dictionary/assets/words.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  @doc "Reads the word list and keeps only the words of the given length."
  @spec start(integer) :: t
  def start(wordLength) do
    start()
    |> Enum.filter(fn (word) -> length(word |> String.to_charlist()) === wordLength end)
  end

  @doc "Returns a random word from the given word list."
  @spec randomWord(t) :: String.t
  def randomWord(dict) do
    dict
    |> Enum.random()
  end

  @doc "Returns all words in the given word list."
  @spec words(t) :: list(String.t)
  def words(dict) do
    dict
  end
end
