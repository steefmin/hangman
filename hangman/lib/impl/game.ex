defmodule Hangman.Impl.Game do
  alias Type

  @type t :: %__MODULE__{
          turns_left: integer,
          game_state: Type.state(),
          letters: list(String.t()),
          used: MapSet.t(String.t())
        }

  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  @doc """
  Create a new game
  """

  @spec newGame :: t
  def newGame() do
    newGame(Dictionary.randomWord())
  end

  @spec newGame(String.t()) :: t
  def newGame(word) do
    %__MODULE__{
      letters:
        word
        |> assertMinimalWordLength(String.length(word))
        |> String.downcase()
        |> String.codepoints()
    }
  end

  defp assertMinimalWordLength(_word, _length = 0) do
    raise "Word not long enough"
  end

  defp assertMinimalWordLength(word, _length) do
    word
  end

  @doc """
  Make a move in a game
  """

  @spec makeMove(t, String.t()) :: {t, Type.tally}
  def makeMove(game = %{game_state: state}, _guess) when state in [:won, :lost] do
    game
    |> returnGameWithTally()
  end

  def makeMove(game, guess) do
    game
    |> validateGuess(guess, Regex.match?(~r/^[a-z]$/, guess))
    |> returnGameWithTally()
  end

  defp validateGuess(game, guess, true) do
    game
    |> acceptGuess(guess, MapSet.member?(game.used, guess))
  end

  defp validateGuess(game, _guess, false) do
    %{ game | game_state: :invalid_guess}
  end

  @spec returnGameWithTally(t) :: {t, Type.tally()}
  defp returnGameWithTally(game) do
    {game, tally(game)}
  end

  @spec acceptGuess(t, String.t(), boolean) :: t
  defp acceptGuess(game, _guess, _guess_already_used = true) do
    %{game | game_state: :already_used}
  end

  defp acceptGuess(game, guess, _guess_already_used) do
    %{game | used: MapSet.put(game.used, guess)}
    |> scoreGuess(Enum.member?(game.letters, guess))
  end

  @spec scoreGuess(t, boolean) :: t
  defp scoreGuess(game, _guess_in_letters = true) do
    new_state = MapSet.subset?(MapSet.new(game.letters), game.used) |> maybeWon()
    %{game | game_state: new_state}
  end

  defp scoreGuess(game = %{turns_left: 1}, _guess_in_letters = false) do
    %{game | game_state: :lost, turns_left: 0}
  end

  defp scoreGuess(game, _guess_in_letters = false) do
    %{game | game_state: :bad_guess, turns_left: game.turns_left - 1}
  end

  @spec maybeWon(boolean) :: :good_guess | :won
  defp maybeWon(true) do
    :won
  end

  defp maybeWon(false) do
    :good_guess
  end

  @doc """
  Create tally for a game state
  """

  @spec tally(t) :: Type.tally
  def tally(game) do
    %{
      turns_left: game.turns_left,
      game_state: game.game_state,
      letters: revealLetters(game),
      used: game.used |> MapSet.to_list()
    }
  end

  @spec revealLetters(t) :: list
  defp revealLetters(game) do
    game.letters
    |> Enum.map(fn letter -> revealLetter(letter, Enum.member?(game.used, letter)) end)
  end

  @spec revealLetter(String.t(), boolean) :: String.t()
  defp revealLetter(letter, _letter_guessed = true) do
    letter
  end

  defp revealLetter(_letter, _letter_guessed = false) do
    "_"
  end
end
