defmodule TextClient.Impl.Player do
  @moduledoc """
  Drives an interactive terminal game, printing feedback and reading guesses.
  """

  @typep game :: Hangman.game
  @typep tally :: Type.tally
  @typep state :: {
    game,
    tally
  }

  @doc "Plays the given game in the terminal until it is won or lost."
  @spec start(game) :: :ok
  def start(game) do
    interact({game, Hangman.tally(game)})
  end

  @doc "Prints the current game state and reads the next guess until the game ends."
  @spec interact(state) :: :ok
  def interact({_game, tally = %{game_state: :won}}) do
    IO.puts(["You won!, ", showWord(tally.letters)])
  end

  def interact({_game, tally = %{game_state: :lost}}) do
    IO.puts(["You lost!, ", showWord(tally.letters)])
  end

  def interact({game, tally}) do
    IO.puts feedbackFor(tally)
    IO.puts currentWord(tally)
    tally = Hangman.makeMove(game, getGuess())
    interact({game, tally})
  end

  @doc "Returns a message revealing the letters of the word."
  @spec showWord(list(String.t)) :: String.t
  def showWord(letters) do
    "the word was: '#{letters |> Enum.join}'"
  end

  @spec feedbackFor(tally) :: String.t
  defp feedbackFor(tally = %{game_state: :initializing}) do
    "Welcome, I'm thinking of a #{tally.letters |> length} letter word"
  end
  defp feedbackFor(_tally = %{game_state: :good_guess}) do
    "Good guess"
  end
  defp feedbackFor(_tally = %{game_state: :bad_guess}) do
    "Sorry, that's not in the word"
  end
  defp feedbackFor(_tally = %{game_state: :invalid_guess}) do
    "That is not a correct guess, try a single lowercase letter"
  end
  defp feedbackFor(_tally = %{game_state: :already_used}) do
    "You already used that letter"
  end

  @spec currentWord(tally) :: list(String.t)
  defp currentWord(tally) do
    [
      "Word so far:       ",
      tally.letters |> Enum.join(" "),
      "                ",
      IO.ANSI.green(),
      "turns left: ",
      IO.ANSI.cyan(),
      tally.turns_left |> Integer.to_string(),
      IO.ANSI.green(),
      ", ",
      "used already: ",
      IO.ANSI.yellow(),
      tally.used |> Enum.join(", "),
      IO.ANSI.reset(),
    ]
  end

  @spec getGuess :: String.t
  defp getGuess() do
    IO.gets("Next letter: ")
    |> String.trim()
    |> String.downcase()
  end
end
