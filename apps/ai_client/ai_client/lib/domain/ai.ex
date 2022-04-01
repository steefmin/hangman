defmodule AiClient.Domain.Ai do
  alias AiClient.Service.Solutions, as: Solutions
  alias AiClient.Service.Io, as: IoService

  @type solutions :: list(String.t)
  @typep game :: Hangman.game
  @typep tally :: Type.tally
  @typep state :: {
    game,
    tally
  }

  @spec start() :: :ok

  def start() do
    game = Hangman.newGame()
    tally = Hangman.tally(game)
    guess({game, tally}, Solutions.initialSolutions(tally), false)
  end

  @spec start(integer) :: :ok

  def start(difficulty) when (difficulty |> is_integer) do
    game = Hangman.newGame(difficulty)
    tally = Hangman.tally(game)
    guess({game, tally}, Solutions.initialSolutions(tally), false)
  end

  @spec step_by_step() :: :ok

  def step_by_step() do
    game = Hangman.newGame()
    tally = Hangman.tally(game)
    guess({game, tally}, Solutions.initialSolutions(tally), true)
  end

  @spec guess(state, solutions, boolean) :: :ok

  defp guess({_game, tally}, _solutions, _interactive) when (tally.game_state in [:won, :lost]) do
    IoService.final(tally)
    :ok
  end

  defp guess({game, tally}, solutions, interactive) when (tally.game_state in [:initializing, :good_guess, :bad_guess]) do
    guess = determineGuess(tally, solutions)
    IoService.interact(tally, guess, solutions, interactive)
    tally = Hangman.makeMove(game, guess)
    solutions = Solutions.removeImpossibleSolutions(solutions, tally)
    guess({game, tally}, solutions, interactive)
  end

  @spec determineGuess(Type.tally, solutions) :: String.t

  defp determineGuess(tally, solutions) do
    Solutions.getLetters(solutions)
    |> Enum.filter(fn (letter) -> letter not in tally.used end)
    |> List.first()
  end
end
