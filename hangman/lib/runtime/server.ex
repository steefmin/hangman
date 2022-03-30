defmodule Hangman.Runtime.Server do
  alias Hangman.Impl.Game

  use GenServer

  @type t :: pid

  ### Client Process

  def start_link() do
    {:ok, pid} = GenServer.start_link(__MODULE__, nil)
    pid
  end

  def start_link(value) do
    {:ok, pid} = GenServer.start_link(__MODULE__, value)
    pid
  end

  def tally(pid) do
    GenServer.call(pid, {:tally})
  end

  def makeMove(pid, guess) do
    tally = GenServer.call(pid, {:make_move, guess})
    {pid, tally}
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
