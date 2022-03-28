defmodule AiClient do

  @spec start() :: :ok
  defdelegate start(), to: AiClient.Domain.Ai

  @spec start(integer) :: :ok
  defdelegate start(difficulty), to: AiClient.Domain.Ai

  @spec step_by_step() :: :ok
  defdelegate step_by_step(), to: AiClient.Domain.Ai
end
