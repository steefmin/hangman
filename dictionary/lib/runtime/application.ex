defmodule Dictionary.Runtime.Application do
  use Application

  def start(_type, _args) do
    Dictionary.Domain.WordList.start()
    |> Dictionary.Domain.WordList.words()
    |> Enum.map(fn (word) -> word |> String.length() end)
    |> Enum.dedup()
    |> Enum.each(fn (num) -> Dictionary.Runtime.Server.start_link(num) end)
    Dictionary.Runtime.Server.start_link()
  end
end
