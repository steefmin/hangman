defmodule AiClient.Service.Io do

  def interact(tally, guess, solutions, _interactive = true) do
    interact(tally, guess, solutions, false)
    IO.gets("Press enter to continue....")
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
  end

  defp displaySolutions(solutions) when (solutions |> length() > 8) do
    solutions |> Enum.count() |> Integer.to_string()
  end

  defp displaySolutions(solutions) do
    solutions = solutions
    |> Enum.join(", ")
    "[" <> solutions <> "]"
  end
end
