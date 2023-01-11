defmodule SessionPlaygroundWeb.Notification do
  alias Phoenix.PubSub

  use Phoenix.Component
  import Phoenix.LiveView

  def on_mount(:default, _params, _session, socket) do
    PubSub.subscribe(SessionPlayground.PubSub, "notifications")

    {:cont,
     socket
     |> assign(:notifications, [])
     |> attach_hook(:close_notifications, :handle_event, &handle_event/3)
     |> attach_hook(:receive_notifications, :handle_info, &handle_info/2)}
  end

  defp handle_event("notifications:close", %{"id" => id}, socket) do
    filtered_notifications = Enum.reject(socket.assigns.notifications, &(&1.id == id))
    {:halt, assign(socket, :notifications, filtered_notifications)}
  end

  defp handle_event("notifications:close-all", _params, socket) do
    {:halt, assign(socket, :notifications, [])}
  end

  defp handle_event(_event_name, _params, socket) do
    {:cont, socket}
  end

  defp handle_info({:notification, notification}, socket) do
    {:halt, assign(socket, :notifications, [notification | socket.assigns.notifications])}
  end

  defp handle_info(_event, socket) do
    {:cont, socket}
  end
end
