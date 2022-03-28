defmodule AiClient.Domain.Ai do
  alias AiClient.Service.Solutions
  alias AiClient.Service.Io, as: IoService

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
    IoService.interact(tally, guess, solutions, interactive)
    {game, tally} = Hangman.makeMove(game, guess)
    solutions = Solutions.removeImpossibleSolutions(solutions, tally)
    guess({game, tally}, solutions, interactive)
  end

  def determineGuess(tally, solutions) do
    Solutions.getLetters(solutions)
    |> Enum.filter(fn (letter) -> letter not in tally.used end)
    |> List.first()
  end
end
