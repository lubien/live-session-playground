defmodule SessionPlaygroundWeb.PageLive do
  use SessionPlaygroundWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: 0)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <p>You are in the home page</p>
      <p><%= @from_live_session %></p>
      <p>Current count: <%= @count %></p>
      <p>
        <.button type="button" phx-click="inc">Increment</.button>
      </p>
    </div>
    """
  end

  def handle_event("inc", _params, socket) do
    {:noreply, assign(socket, :count, socket.assigns.count + 1)}
  end
end
