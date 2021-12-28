defmodule RideWeb.HeroComponent do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_component
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <p>Hello, <%= assigns.name %></p>
    """
  end
end
