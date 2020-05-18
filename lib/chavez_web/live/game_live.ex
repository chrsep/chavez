defmodule ChavezWeb.GameLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :temperature, 20)}
  end
end