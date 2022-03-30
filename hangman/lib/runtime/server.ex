defmodule Hangman.Runtime.Server do
  alias Hangman.Impl.Game

  use GenServer

  @type t :: pid

  ### Client Process

  def start_link(value) when (value |> is_integer()) do
    GenServer.start_link(__MODULE__, value)
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def tally(pid) do
    GenServer.call(pid, {:tally})
  end

  def makeMove(pid, guess) do
    GenServer.call(pid, {:make_move, guess})
  end


  ### Server Process

  def init(args) when (args |> is_integer) do
    {:ok, Game.newGame(args)}
  end

  def init(_args) do
    {:ok, Game.newGame()}
  end

  def handle_call({:make_move, guess}, _from, game) do
    {game, tally} = Game.makeMove(game, guess)
    {:reply, tally, game}
  end

  def handle_call({:tally}, _from, game) do
    {:reply, Game.tally(game), game}
  end
end
