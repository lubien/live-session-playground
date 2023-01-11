defmodule SessionPlaygroundWeb.NotificationLive do
  use SessionPlaygroundWeb, :live_view

  alias Phoenix.PubSub

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.button type="button" phx-click="send_test_notification">
        Send Test Notification
      </.button>
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

  defp random_notification do
    id = Ecto.UUID.generate()

    %{
      id: id,
      title: "Test notification",
      description: "ID #{id}"
    }
  end
end
