defmodule B1Web.PageControllerTest do
  use B1Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/hangman")
    assert html_response(conn, 200) =~ "Awesome hangman"
  end
end
