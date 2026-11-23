# Hangman Game

## Run locally

```
mix setup   # fetch dependencies
mix serve   # b1 on http://localhost:4000, b2 on http://localhost:4001
```

Needs Erlang and Elixir installed. For the terminal clients instead, run `iex -S mix`
and call `TextClient.start()` or `AiClient.start()`.

## Apps

- `ai_client`: computer player that plays a game by narrowing the dictionary words that fit the tally and guessing letters from them; `AiClient.load/1` starts many games at once.
- `b1`: Phoenix web app with server-rendered pages under `/hangman` (port 4000).
- `b2`: Phoenix LiveView app at `/` with keyboard input and an SVG or ASCII figure (port 4001).
- `dictionary`: server that loads a word list and returns a random word or all words, optionally of a given length.
- `hangman`: game engine; each game runs in its own process, with a random word from `dictionary` and an optional word length as difficulty.
- `text_client`: terminal client that connects to a remote hangman node and falls back to a local game.
