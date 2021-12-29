defmodule RideWeb.CounterTemplate do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_view
  use Phoenix.LiveView


  def mount(_params, _session, socket) do
    {:ok, assign(socket, :count, 0)}
  end

  def handle_event("inc", _, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end

  def handle_event("dec", _, socket) do
    {:noreply, update(socket, :count, &(&1 - 1))}
  end


  def render(assigns) do
    ~H"""
    <div class="card text-center shadow-2xl lg:card-side bg-base text-accent-content">
      <div class="card-body">
        <h1 class="card-title text-primary font-extralight">The count is: <p class="font-bold text-3xl"><%= @count %></p></h1>
        <div class="justify-center card-actions">
          <button phx-click="dec" class="btn btn-outline btn-circle">-</button>
          <button phx-click="inc" class="btn btn-outline btn-circle">+</button>
        </div>
      </div>
    </div>
    """
  end
end
