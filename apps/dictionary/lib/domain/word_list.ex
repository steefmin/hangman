defmodule Dictionary.Domain.WordList do
  @type t :: list(String.t)

  @spec start() :: t
  def start() do
    "/home/steef/development/codestool/hangman_game/apps/dictionary/assets/words.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  @spec start(integer) :: t
  def start(wordLength) do
    start()
    |> Enum.filter(fn (word) -> length(word |> String.to_charlist()) === wordLength end)
  end

  @spec randomWord(t) :: String.t
  def randomWord(dict) do
    dict
    |> Enum.random()
  end

  @spec words(t) :: list(String.t)
  def words(dict) do
    dict
  end
end
