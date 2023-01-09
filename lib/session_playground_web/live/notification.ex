defmodule SessionPlaygroundWeb.Notification do
  import Phoenix.LiveView
  use Phoenix.Component
  alias Phoenix.PubSub

  def on_mount(:default, _params, _session, socket) do
    PubSub.subscribe(SessionPlayground.PubSub, "notifications")

    {:cont,
     socket
     |> assign(:notifications, [])
     |> attach_hook(:accept_notification, :handle_info, &handle_notification/2)
     |> attach_hook(:handle_notification_event, :handle_event, &handle_event/3)}
  end

  def handle_notification({:notification, notification}, socket) do
    {:cont, assign(socket, :notifications, [notification | socket.assigns.notifications])}
  end

  def handle_event("notifications:close", %{"id" => id}, socket) do
    filtered_notifications = Enum.reject(socket.assigns.notifications, &(&1.id == id))
    {:halt, assign(socket, :notifications, filtered_notifications)}
  end

  def handle_event("notifications:close-all", _params, socket) do
    {:halt, assign(socket, :notifications, [])}
  end

  def handle_event(_event, _params, socket) do
    {:cont, socket}
  end
end
