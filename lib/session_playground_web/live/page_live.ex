defmodule SessionPlaygroundWeb.PageLive do
  use SessionPlaygroundWeb, :live_view_without_layout

  alias Phoenix.PubSub

  def mount(_params, _session, socket) do
    PubSub.subscribe(SessionPlayground.PubSub, "notifications")

    {:ok,
     socket
     |> assign(:notifications, [random_notification(), random_notification()]),
     temporary_assigns: [notifications: []]}
  end

  def handle_event("send_test_notification", _params, socket) do
    PubSub.broadcast!(
      SessionPlayground.PubSub,
      "notifications",
      {:notification, random_notification()}
    )

    {:noreply, socket}
  end

  def handle_info({:notification, notification}, socket) do
    {:noreply, assign(socket, :notifications, [notification | socket.assigns.notifications])}
  end

  defp random_notification do
    id = Ecto.UUID.generate()

    %{
      id: id,
      title: "Test notification",
      description: "ID #{id}"
    }
  end
end
