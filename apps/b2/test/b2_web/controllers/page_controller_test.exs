defmodule B2Web.PageControllerTest do
  use B2Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Awesome Live Hangman"
  end
end
