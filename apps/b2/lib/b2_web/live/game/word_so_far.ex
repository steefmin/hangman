defmodule B2Web.Live.Game.WordSoFar do
  use B2Web, :live_component

  @states %{
    initializing: "Guess the word, a letter at a time",
    good_guess: "That's correct, keep going!",
    bad_guess: "Sorry, that's not in the word",
    already_used: "You already used that letter",
    invalid_guess: "That is not a valid guess",
    won: "You won!",
    lost: "Sorry, you lost",
  }

  def mount(socket) do
    {:ok, socket}
  end

  defp state_name(state) do
    @states[state] || "Unknown state"
  end

  defp letter_class(ch) when (ch != "_") do
    "letter correct"
  end

  defp letter_class(_) do
    "letter "
  end

  def render(assigns) do
    ~H"""
      <div class="word-so-far">

        <div class="game-state">
          <%= @tally.game_state |> state_name() %>
        </div>

        <div class="letters">
        <%= for ch <- @tally.letters do %>
          <div class={ch |> letter_class() }>
            <%= ch %>
          </div>
        <% end %>
        </div>

      </div>
    """
  end
end
