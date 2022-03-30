defmodule Hangman.Runtime.Application do

  @super_name GameFactory

  def start(_type, _args) do
    Supervisor.start_link(
        [
          {
            DynamicSupervisor,
            strategy: :one_for_one,
            name: @super_name
          },
        ],
        [
          strategy: :one_for_one
        ]
      )
  end

  def startGame(value) do
    DynamicSupervisor.start_child(@super_name, {Hangman.Runtime.Server, value})
  end
end
