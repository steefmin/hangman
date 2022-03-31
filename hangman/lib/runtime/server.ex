defmodule Hangman.Runtime.Server do
  alias Hangman.Impl.Game
  alias Hangman.Runtime.Watchdog

  use GenServer, restart: :transient

  @type t :: pid

  @idle_timeout 10 * 60 * 1000 # 10 minutes

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
    {:ok, {Game.newGame(args), Watchdog.start(@idle_timeout)}}
  end

  def init(_args) do
    {:ok, {Game.newGame(), Watchdog.start(@idle_timeout)}}
  end

  def handle_call({:make_move, guess}, _from, {game, watcher}) do
    Watchdog.im_alive(watcher)
    {game, tally} = Game.makeMove(game, guess)
    {:reply, tally, {game, watcher}}
  end

  def handle_call({:tally}, _from, {game, watcher}) do
    Watchdog.im_alive(watcher)
    {:reply, Game.tally(game), {game, watcher}}
  end
end
