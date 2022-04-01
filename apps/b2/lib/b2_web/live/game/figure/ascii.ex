defmodule B2Web.Live.Game.Figure.Ascii do

  use B2Web, :live_component

  def render(assigns) do
    ~H"""
    <pre>
      <%= figure_for(assigns.tally.turns_left) %>
    </pre>
    """
  end


  def figure_for(0) do
    "
          +---+
          |   |
          O   |
         /|\\  |
         / \\  |
              |
        =========
    "
  end

  def figure_for(1) do
    "
          +---+
          |   |
          O   |
         /|\\  |
         /    |
              |
        =========
    "
  end

  def figure_for(2) do
    "
          +---+
          |   |
          O   |
          |\\  |
         /    |
              |
        =========
    "
  end

  def figure_for(3) do
    "
          +---+
          |   |
          O   |
          |\\  |
              |
              |
        =========
    "
  end

  def figure_for(4) do
    "
          +---+
          |   |
          O   |
          |   |
              |
              |
        =========
    "
  end

  def figure_for(5) do
    "
          +---+
          |   |
          O   |
              |
              |
              |
        =========
    "
  end

  def figure_for(6) do
    "
          +---+
          |   |
              |
              |
              |
              |
        =========
    "
  end

  def figure_for(7) do
    "
          +---+
              |
              |
              |
              |
              |
        =========        
    "
  end
end
