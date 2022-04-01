defmodule B1Web.HangmanView.Helpers.Figure do
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
