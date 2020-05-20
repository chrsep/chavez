defmodule ChavezWeb.LeaderboardLive do
  use Phoenix.LiveView

  import Chavez.Game

  def mount(_params, _session, socket) do
    :timer.send_interval(1000, self(), :refresh)
    {:ok, assign(socket, :scores, list_scores)}
  end

  def handle_info(:refresh, socket) do
    {:noreply, assign(socket, :scores, list_scores)}
  end
end
