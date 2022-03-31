defmodule B2Web.Live.Game.Alphabet do

  use B2Web, :live_component

  def mount(socket) do
    letters = (?a..?z |> Enum.map(fn (ch) -> << ch :: utf8 >> end ))
    socket = assign(socket, :letters, letters)
    {:ok, socket}
  end

  defp letter_class(letter, tally) do
    "letter " <> class_of(letter, tally)
  end

  defp class_of(letter, tally) do
    cond do
      Enum.member?(tally.letters, letter) -> "correct"
      Enum.member?(tally.used, letter) -> "wrong"
      true -> ""
    end
  end

  def render(assigns) do
    ~H"""
      <div class="alphabet">
        <%= for letter <- @letters do %>
        <div class={ letter_class(letter, @tally)} phx-click="make_move" phx-value-key={letter}>
        <%= letter %>
        </div>
        <% end%>
      </div>
    """
  end
end
