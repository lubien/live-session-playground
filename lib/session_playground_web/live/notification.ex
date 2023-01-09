defmodule SessionPlaygroundWeb.Notification do
  import Phoenix.LiveView
  use Phoenix.Component
  alias Phoenix.PubSub

  def on_mount(:default, _params, _session, socket) do
    PubSub.subscribe(SessionPlayground.PubSub, "notifications")

    {:cont,
     socket
     |> assign(:notifications, [])
     |> attach_hook(:accept_notification, :handle_info, &handle_notification/2)}
  end

  def handle_notification({:notification, notification}, socket) do
    {:cont, assign(socket, :notifications, [notification | socket.assigns.notifications])}
  end
end
