defmodule AiClient.Service.Solutions do
  alias Type

  @spec initialSolutions(Type.tally) :: list(String.t)
  def initialSolutions(tally) do
    tally.letters
    |> Enum.count()
    |> solutionsWithLength()
  end

  @spec solutionsWithLength(integer) :: list(String.t)
  defp solutionsWithLength(length) when (length |> is_integer()) do
    Dictionary.getWordList(length)
  end

  @spec getLetters(list(String.t)) :: list(String.t)
  def getLetters(solutions) do
    solutions
    |> Enum.join()
    |> String.split("", trim: true)
    |> Enum.frequencies()
    |> Enum.sort(fn ({_, a}, {_, b})-> a >= b end)
    |> Enum.map(fn ({a, _}) -> a end)
  end

  def removeImpossibleSolutions(solutions, tally) do
    solutions
    |> Enum.filter(fn (word) -> wordMatches(word, tally.letters) end)
  end

  @spec wordMatches(String.t, list(String.t)) :: boolean
  defp wordMatches(word, letters) do
    String.match?(word, makeRegex(letters))
  end

  defp makeRegex(letters) do
    letters
    |> Enum.join()
    |> String.replace("_", ".")
    |> Regex.compile!()
  end
end
