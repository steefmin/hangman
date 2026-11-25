defmodule AiClient do
  @moduledoc """
  Starts hangman games played automatically by an AI client.
  """

  @doc "Starts an AI-played game with a randomly selected difficulty."
  @spec start() :: :ok
  defdelegate start(), to: AiClient.Domain.Ai

  @doc "Starts an AI-played game with the given difficulty."
  @spec start(integer) :: :ok
  defdelegate start(difficulty), to: AiClient.Domain.Ai

  @doc "Starts an AI-played game and pauses after each guess."
  @spec step_by_step() :: :ok
  defdelegate step_by_step(), to: AiClient.Domain.Ai

  @doc "Starts the given number of AI-played games, spaced by the default delay."
  def load(n) do
    load(n, 50)
  end

  @doc "Starts the given number of AI-played games, spacing each start by the given delay."
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
