defmodule Dictionary do

  @word_list "assets/words.txt"
  |> File.read!()
  |> String.split("\n", trim: true)

  @spec randomWord() :: String.t()
  def randomWord() do
    getWordList()
    |> Enum.random()
  end

  @spec randomWord(integer) :: String.t()
  def randomWord(length) do
    getWordList(length)
    |> Enum.random()
  end

  @spec getWordList(integer()) :: list()
  def getWordList(wordlength) when (wordlength |> is_integer()) do
    getWordList()
    |> Enum.filter(fn (word) -> length(word |> String.to_charlist()) === wordlength end)
  end

  @spec getWordList() :: list()
  def getWordList() do
    @word_list
  end
end
