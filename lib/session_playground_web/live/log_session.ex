defmodule SessionPlaygroundWeb.LogSession do
  use Phoenix.Component
  import Phoenix.LiveView

  def on_mount(hello_name, _params, _session, socket) do
    IO.puts("User came to this live view")

    {:cont,
     socket
     |> assign(:from_live_session, hello_name)
     |> attach_hook(:listen_to_events, :handle_event, &handle_event/3)}
  end

  defp handle_event(event_name, _params, socket) do
    IO.puts("Event fired: #{event_name}")
    {:cont, socket}
  end
end
