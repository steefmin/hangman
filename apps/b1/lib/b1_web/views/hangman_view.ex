defmodule B1Web.HangmanView do
  use B1Web, :view

  @status_fields %{
    initializing: {"initializing", "Guess the word, a letter at a time"},
    good_guess: {"good-guess", "That's correct, keep going!"},
    bad_guess: {"bad-guess", "Sorry, that's not in the word"},
    already_used: {"already-used", "You already used that letter"},
    invalid_guess: {"invalid-guess", "That is not a valid guess"},
    won: {"won", "You won!"},
    lost: {"lost", "Sorry, you lost"}
  }

  def move_status(state) do
    {class, msg} = @status_fields[state]
    "<div class='status #{class}'>#{msg}</div>" |> raw()
  end

  def final(state) when (state in [:lost, :won]) do
    true
  end

  def final(_state) do
    false
  end

  def form(conn, state) when (state in [:lost, :won]) do
    button("New game", to: Routes.hangman_path(conn, :create))
  end

  def form(conn, state) do
    form_for(conn, Routes.hangman_path(conn, :update), [as: "make_move", method: :put], fn form ->
      [
        text_input(form, :guess, autofocus: true, disabled: final(state)),
        " ",
        submit("Make guess", disabled: final(state))
      ]
    end)
  end

  defdelegate figure_for(n), to: B1Web.HangmanView.Helpers.Figure
end
