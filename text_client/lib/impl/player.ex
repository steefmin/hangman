defmodule TextClient.Impl.Player do

  @typep game :: Hangman.game
  @typep tally :: Type.tally
  @typep state :: {
    game,
    tally
  }

  @spec start() :: :ok
  def start() do
    game = Hangman.newGame()
    interact({game, Hangman.tally(game)})
  end

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
    Hangman.makeMove(game, getGuess())
    |> interact()
  end

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
      "Word so far: #{tally.letters |> Enum.join(" ")}, ",
      "turns left: #{tally.turns_left}, ",
      "used already: #{tally.used |> Enum.join(", ")}",
    ]
  end

  @spec getGuess :: String.t
  defp getGuess() do
    IO.gets("Next letter: ")
    |> String.trim()
    |> String.downcase()
  end
end
