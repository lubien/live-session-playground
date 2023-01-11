defmodule SessionPlaygroundWeb.MountLive do
  use SessionPlaygroundWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :socket, socket)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1 class="text-2xl mb-8">
        My Phoenix.LiveView.Socket ID is <strong class="font-bold"><%= @socket.id %></strong>
      </h1>

      <h4 class="text-xl">
        Here's the value of <strong class="font-bold">socket.private.lifecycle.mount</strong>
      </h4>

      <ul>
        <li :for={item <- @socket.private.lifecycle.mount}>
          <.list>
            <:item title="id"><strong class="font-bold"><%= inspect(item.id) %></strong></:item>
            <:item title="stage"><%= inspect(item.stage) %></:item>
            <:item title="function"><%= inspect(item.function) %></:item>
          </.list>

          <hr class="mt-2" />
        </li>
      </ul>
    </div>
    """
  end
end
