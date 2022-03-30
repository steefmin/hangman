defmodule B1Web.HangmanController do
  use B1Web, :controller

  def index(conn, _params) do
    conn = assign(conn, :page_title, "Welcome to hangman")
    render(conn, "index.html")
  end

  def create(conn, _params) do
    game = Hangman.newGame()

    put_session(conn, :game, game)
    |> redirect(to: Routes.hangman_path(conn, :show))
  end

  def update(conn, %{"make_move" => %{"guess" => guess}}) do
    conn
    |> get_session(:game)
    |> Hangman.makeMove(guess)

    put_in(conn.params["make_move"]["guess"], "")
    |> redirect(to: Routes.hangman_path(conn, :show))
  end

  def show(conn, _params) do
    tally =
      conn
      |> get_session(:game)
      |> Hangman.tally()

    conn
    |> assign(:tally, tally)
    |> render("game.html")
  end
end
