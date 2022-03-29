defmodule Dictionary.Runtime.Application do
  use Application

  def start(_type, _args) do
    Dictionary.Domain.WordList.start()
    |> Dictionary.Domain.WordList.words()
    |> Enum.map(fn word -> word |> String.length() end)
    |> Enum.dedup()
    |> Enum.each(fn num -> Dictionary.Runtime.Server.start_link(num) |> assertStart() end)

    Dictionary.Runtime.Server.start_link() |> assertStart()
  end

  defp assertStart({:ok, _} = any) do
    any
  end

  defp assertStart({:error, {:already_started, _}} = any) do
    any
  end
end
