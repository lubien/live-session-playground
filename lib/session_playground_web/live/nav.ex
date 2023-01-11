defmodule SessionPlaygroundWeb.Nav do
  use Phoenix.Component

  def on_mount(:default, _params, _session, socket) do
    {:cont, assign(socket, :active_nav, active_tab(socket.view, socket.assigns.live_action))}
  end

  defp active_tab(SessionPlaygroundWeb.NotificationLive, :show), do: :notification
  defp active_tab(SessionPlaygroundWeb.MountLive, :mount_a), do: :mount_a
  defp active_tab(SessionPlaygroundWeb.MountLive, :mount_b), do: :mount_b
  defp active_tab(SessionPlaygroundWeb.MountLive, :mount_c), do: :mount_c
  defp active_tab(SessionPlaygroundWeb.UserLoginLive, _live_action), do: :login
  defp active_tab(SessionPlaygroundWeb.UserRegistrationLive, _live_action), do: :register
  defp active_tab(SessionPlaygroundWeb.UserSettingsLive, _live_action), do: :settings
  defp active_tab(_view, _live_action), do: nil
end
