defmodule AiClient.Providers.Solutions do
  alias Type

  @spec solutionsWithLength(integer) :: list(String.t)
  def solutionsWithLength(length) when (length |> is_integer()) do
    Dictionary.getWordList(length)
  end

  @spec initialSolutions(Type.tally) :: list(String.t)
  def initialSolutions(tally) do
    tally.letters
    |> Enum.count()
    |> solutionsWithLength()
  end
end
