defmodule AiClient.Providers.Solutions do
  alias Type

  @spec solutionsWithLength(integer) :: list(String.t)
  def solutionsWithLength(length) when (length |> is_integer()) do
    Dictionary.getWordList(length)
  end

  @spec initialSolutions(Hangman.Impl.Game.t) :: list(String.t)
  def initialSolutions(game) do
    tally = Hangman.tally(game)
    tally.letters
    |> Enum.count()
    |> solutionsWithLength()
  end
end
