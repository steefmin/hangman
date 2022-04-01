defmodule AiClient do

  @spec start() :: :ok
  defdelegate start(), to: AiClient.Domain.Ai

  @spec start(integer) :: :ok
  defdelegate start(difficulty), to: AiClient.Domain.Ai

  @spec step_by_step() :: :ok
  defdelegate step_by_step(), to: AiClient.Domain.Ai

  def load(n) do
    load(n, 50)
  end

  def load(n, sleepiness) do
    1..n
    |> Enum.each(fn (num) -> spawn(spawnGame(num, sleepiness)) end)
  end

  defp spawnGame(num, sleepiness) do
    fn () ->
      Process.sleep(num * sleepiness)
      start()
    end
  end
end
