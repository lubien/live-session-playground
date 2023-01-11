defmodule SessionPlaygroundWeb.PageLive do
  use SessionPlaygroundWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex">
      You are in the home page
    </div>
    """
  end
end
