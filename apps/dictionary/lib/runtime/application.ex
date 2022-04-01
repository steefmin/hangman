defmodule Dictionary.Runtime.Application do

  def start(_type, _args) do
    buildChildren()
    |> Supervisor.start_link(
        [name: Dictionary.Runtime.Supervisor, strategy: :one_for_one]
      )
  end

  defp buildChildren() do
    first = Supervisor.child_spec(
      {Dictionary.Runtime.Server, []},
      id: {Dictionary.Runtime.Server, 0}
      )

    rest = Dictionary.Domain.WordList.start()
    |> Dictionary.Domain.WordList.words()
    |> Enum.map(fn word -> word |> String.length() end)
    |> Enum.uniq()
    |> Enum.sort()
    |> Enum.map(
        fn num ->
          Supervisor.child_spec(
            { Dictionary.Runtime.Server, [num]},
            id: {Dictionary.Runtime.Server, num}
          )
        end
      )

    [first | rest]
  end
end
