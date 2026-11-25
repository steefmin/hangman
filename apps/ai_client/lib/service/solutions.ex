defmodule AiClient.Service.Solutions do
  @moduledoc """
  Builds and filters possible word solutions for the AI client's current game.
  """

  alias AiClient.Domain.Ai
  alias Type

  @spec initialSolutions(Type.tally) :: Ai.solutions

  @doc "Returns dictionary words whose length matches the current game."
  def initialSolutions(tally) do
    tally.letters
    |> Enum.count()
    |> solutionsWithLength()
  end

  @spec solutionsWithLength(integer) :: Ai.solutions

  defp solutionsWithLength(length) when (length |> is_integer()) do
    Dictionary.words(length)
  end

  @spec getLetters(Ai.solutions) :: list(String.t)

  @doc "Returns the solution letters ordered from most frequent to least frequent."
  def getLetters(solutions) do
    solutions
    |> Enum.join()
    |> String.split("", trim: true)
    |> Enum.frequencies()
    |> Enum.sort(fn ({_, a}, {_, b})-> a >= b end)
    |> Enum.map(fn ({a, _}) -> a end)
  end

  @spec removeImpossibleSolutions(Ai.solutions, Type.tally) :: Ai.solutions

  @doc "Removes solutions that do not match the letters revealed in the current tally."
  def removeImpossibleSolutions(solutions, tally) do
    solutions
    |> Enum.filter(fn (word) -> wordMatches(word, tally.letters) end)
  end

  @spec wordMatches(String.t, list(String.t)) :: boolean

  defp wordMatches(word, letters) do
    String.match?(word, makeRegex(letters))
  end

  @spec makeRegex(list(String.t)) :: Regex.t

  defp makeRegex(letters) do
    letters
    |> Enum.join()
    |> String.replace("_", ".")
    |> Regex.compile!()
  end
end
