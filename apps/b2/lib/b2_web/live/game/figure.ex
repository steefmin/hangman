defmodule B2Web.Live.Game.Figure do
  alias B2Web.Live.Game.Figure.Ascii
  alias B2Web.Live.Game.Figure.Svg

  use B2Web, :live_component

  require Logger

  def render(%{figure: :ascii} = assigns) do
    Ascii.render(assigns)
  end

  def render(assigns) do
    Svg.render(assigns)
  end
end
