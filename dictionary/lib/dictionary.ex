defmodule Dictionary do

  @word_list "assets/words.txt"
  |> File.read!()
  |> String.split("\n", trim: true)

  def randomWord() do
    @word_list
    |> Enum.random()
  end
end
