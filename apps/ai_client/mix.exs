defmodule AiClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :ai_client,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      compilers: Mix.compilers, 
      build_embedded: Mix.env() == :prod,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # included_applications: [:hangman, :dictionary],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:dictionary, in_umbrella: true},
      {:hangman, in_umbrella: true},
    ]
  end
end
