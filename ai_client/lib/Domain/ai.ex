defmodule AiClient.Domain.Ai do
  alias AiClient.Providers.Solutions

  @type solutions :: list(String.t)

  def start do
    game = Hangman.newGame()
    tally = Hangman.tally(game)
    guess({game, tally}, Solutions.initialSolutions(tally), false)
  end

  @spec start(integer) :: :ok
  def start(difficulty) do
    game = Hangman.newGame(difficulty)
    tally = Hangman.tally(game)
    guess({game, tally}, Solutions.initialSolutions(tally), false)
  end

  def step_by_step do
    game = Hangman.newGame()
    tally = Hangman.tally(game)
    guess({game, tally}, Solutions.initialSolutions(tally), true)
  end

  @spec guess({Hangman.Impl.Game.t, Type.tally}, solutions, boolean) :: :ok
  def guess({_game, tally}, _solutions, _interactive) when (tally.game_state in [:won, :lost]) do
    IO.puts(
      [
        "Game over! Result: ",
        tally.game_state |> to_string,
        "! The word was: ",
        tally.letters,
      ]
    )
  end

  def guess({game, tally}, solutions, interactive) when (tally.game_state in [:initializing, :good_guess, :bad_guess]) do
    guess = determineGuess(tally, solutions)
    interact(tally, guess, solutions, interactive)
    {game, tally} = Hangman.makeMove(game, guess)
    solutions = removeImpossibleSolutions(solutions, tally)
    guess({game, tally}, solutions, interactive)
  end

  def removeImpossibleSolutions(solutions, tally) do
    solutions
    |> Enum.filter(fn (word) -> wordMatches(word, tally.letters) end)
  end

  @spec wordMatches(String.t, list(String.t)) :: boolean
  def wordMatches(word, letters) do
    String.match?(word, makeRegex(letters))
  end

  def makeRegex(letters) do
    letters
    |> Enum.join()
    |> String.replace("_", ".")
    |> Regex.compile!()
  end

  def determineGuess(tally, solutions) do
    getLetters(solutions)
    |> Enum.filter(fn (letter) -> letter not in tally.used end)
    |> List.first()
  end

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

  def displaySolutions(solutions) when (solutions |> length() > 8) do
    solutions |> Enum.count() |> Integer.to_string()
  end

  def displaySolutions(solutions) do
    solutions = solutions
    |> Enum.join(", ")
    "[" <> solutions <> "]"
  end

  @spec getLetters(list(String.t)) :: list(String.t)
  def getLetters(solutions) do
    solutions
    |> Enum.join()
    |> String.split("", trim: true)
    |> Enum.frequencies()
    |> Enum.sort(fn (a, b)-> elem(a, 1) > elem(b, 1) end)
    |> Enum.map(fn (tup) -> elem(tup, 0) end)
  end
end
