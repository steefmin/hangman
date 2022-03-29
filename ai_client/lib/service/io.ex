defmodule AiClient.Service.Io do
  alias AiClient.Domain.Ai

  @spec interact(Type.tally, String.t, Ai.solutions, boolean) :: :ok

  def interact(tally, guess, solutions, _interactive = true) do
    interact(tally, guess, solutions, false)
    IO.gets("Press enter to continue....")
    :ok
  end

  def interact(tally, guess, solutions, _interactive) do
    IO.puts(
      [
        "Current state: ",
        tally.letters,
        ". Solutions left: ",
        displaySolutions(solutions),
        ". Going for guess: ",
        guess,
      ]
    )
    :ok
  end

  @spec displaySolutions(Ai.solutions) :: String.t

  defp displaySolutions(solutions) when (solutions |> length() > 8) do
    solutions |> Enum.count() |> Integer.to_string()
  end

  defp displaySolutions(solutions) do
    solutions = solutions
    |> Enum.join(", ")
    "[" <> solutions <> "]"
  end
end
