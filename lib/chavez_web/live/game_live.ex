defmodule ChavezWeb.GameLive do
  use Phoenix.LiveView


  def mount(_params, _session, socket) do
    {:ok, assign(socket, :value, 1)}
  end

  def handle_event("inc", _value, socket) do
    {:noreply, update(socket, :value, &(&1 + 1))}
  end

  def handle_event("dec", _value, socket) do
    {:noreply, update(socket, :value, &(&1 - 1))}
  end
end