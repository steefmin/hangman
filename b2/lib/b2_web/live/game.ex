defmodule B2Web.Live.Game do
  use B2Web, :live_view
  require Logger

  def mount(_, _, socket) do
    game = Hangman.newGame()
    tally = Hangman.tally(game)
    socket =
      socket
      |> assign(:game, game)
      |> assign(:figure, :svg)
      |> assign(:tally, tally)
      |> assign(:page_title, "Play")
    {:ok, socket}
  end

  def handle_event("make_move", %{"key" => key}, socket) do
    tally = Hangman.makeMove(socket.assigns.game, key)
    socket = assign(socket, :tally, tally)
    {:noreply, socket}
  end

  def handle_event("switch_figure_mode", %{"mode" => "ascii"}, socket) do
    Logger.debug("hit ascii")
    {:noreply, assign(socket, :figure, :ascii)}
  end

  def handle_event("switch_figure_mode", %{"mode" => "svg"}, socket) do
    Logger.debug("hit svg")
    {:noreply, assign(socket, :figure, :svg)}
  end

  def render(assigns) do
    ~L"""
      <div class="game-holder" phx-window-keyup="make_move">
        <%= live_component(__MODULE__.Figure, tally: assigns.tally, figure: assigns.figure, id: 'figure') %>
        <% other = @figure |> otherMode() %>
        <button phx-click="switch_figure_mode" phx-value-mode="<%= other %>"><%= @figure |> otherMode() %></button>
        <%= live_component(__MODULE__.Alphabet, tally: assigns.tally, id: 'alphabet') %>
        <%= live_component(__MODULE__.WordSoFar, tally: assigns.tally, id: 'wordsofar') %>
      </div>
    """
  end

  defp otherMode(:ascii) do
    :svg |> to_string()
  end
  defp otherMode(:svg) do
    :ascii |> to_string()
  end
end
