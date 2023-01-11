defmodule SessionPlaygroundWeb.NotificationLive do
  use SessionPlaygroundWeb, :live_view

  alias Phoenix.PubSub

  def mount(_params, _session, socket) do
    PubSub.subscribe(SessionPlayground.PubSub, "notifications")

    {:ok, socket |> assign(:notifications, [])}
  end

  def render(assigns) do
    ~H"""
    <div class="flex">
      <button
        type="button"
        phx-click="send_test_notification"
        class="group relative rounded-2xl px-6 py-4 text-sm font-semibold leading-6 text-zinc-900 sm:py-6"
      >
        <span class="absolute inset-0 rounded-2xl bg-zinc-100 transition group-hover:bg-zinc-150 sm:group-hover:scale-105">
        </span>
        <span class="relative flex items-center gap-4 sm:flex-col">
          Send Test Notification
        </span>
      </button>
    </div>
    """
  end

  def handle_event("send_test_notification", _params, socket) do
    PubSub.broadcast!(
      SessionPlayground.PubSub,
      "notifications",
      {:notification, random_notification()}
    )

    {:noreply, socket}
  end

  def handle_event("notifications:close", %{"id" => id}, socket) do
    filtered_notifications = Enum.reject(socket.assigns.notifications, &(&1.id == id))
    {:noreply, assign(socket, :notifications, filtered_notifications)}
  end

  def handle_event("notifications:close-all", _params, socket) do
    {:noreply, assign(socket, :notifications, [])}
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
