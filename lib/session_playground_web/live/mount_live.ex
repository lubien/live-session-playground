defmodule SessionPlaygroundWeb.MountLive do
  use SessionPlaygroundWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :mount_id, Ecto.UUID.generate())}
  end

  def render(assigns) do
    ~H"""
    <div>
      <%= @mount_id %>

      <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-4 sm:grid-cols-3">
        <.link
          patch={~p"/mount-a"}
          class="group relative rounded-2xl px-6 py-4 text-sm font-semibold leading-6 text-zinc-900 sm:py-6"
        >
          <span class="relative flex items-center gap-4 sm:flex-col">
            Go to Mount A
          </span>
        </.link>

        <.link
          patch={~p"/mount-b"}
          class="group relative rounded-2xl px-6 py-4 text-sm font-semibold leading-6 text-zinc-900 sm:py-6"
        >
          <span class="relative flex items-center gap-4 sm:flex-col">
            Go to Mount B
          </span>
        </.link>
      </div>
    </div>
    """
  end
end
