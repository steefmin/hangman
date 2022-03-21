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
      letters: word |> String.downcase() |> String.codepoints()
    }
  end

  @doc """
  Make a move in a game
  """

  @spec makeMove(t, String.t()) :: {t, Type.tally()}
  def makeMove(game = %{game_state: state}, _guess) when state in [:won, :lost] do
    game
    |> returnGameWithTally()
  end

  def makeMove(game, guess) do
    acceptGuess(game, guess, MapSet.member?(game.used, guess))
    |> returnGameWithTally()
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
  end

  @spec tally(t) :: Type.tally()
  defp tally(game) do
    %{
      turns_left: game.turns_left,
      game_state: game.game_state,
      letters: [],
      used: game.used |> MapSet.to_list()
    }
  end
end
