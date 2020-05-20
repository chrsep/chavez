defmodule ChavezWeb.GameLive do
  use Phoenix.LiveView

  import Chavez.Game

  def mount(_params, _session, socket) do
    possibleValues = 1..8

    values = Enum.concat(possibleValues, possibleValues)

    #      |> Enum.shuffle()

    truth_table = for index <- 0..15, into: %{}, do: {index, false}
    value_table = for index <- 0..15, into: %{}, do: {index, Enum.at(values, index)}

    socket =
      socket
      |> assign(:saved, false)
      |> assign(:name, "")
      |> assign(:tref, nil)
      |> assign(:tries, 0)
      |> assign(:time, 0)
      |> assign(:valueTable, value_table)
      |> assign(:truthTable, truth_table)
      |> assign(:first, nil)
      |> assign(:second, nil)
      |> assign(:finish, false)

    {:ok, socket}
  end

  def handle_event(
        "box-click",
        %{"selected" => selected},
        %{assigns: assigns} = socket
      ) do
    {result, _} = Integer.parse(selected)

    case assigns do
      %{first: first} when first == nil ->
        {:noreply, assign(socket, :first, result)}

      %{first: first} when first == result ->
        {:noreply, socket}

      %{first: first, second: second, valueTable: values, time: time} when second == nil ->
        :timer.send_after(300, self(), :reset)

        if time == 0 do
          send(self(), :start_timer)
        end

        update_truth_table = fn old_truth_table ->
          first_value = values[first]
          second_value = values[result]

          new_truth_table =
            case first_value do
              ^second_value -> %{old_truth_table | first => true, result => true}
              _ -> old_truth_table
            end

          if new_truth_table |> Map.values() |> Enum.all?() do
            send(self(), :finish_game)
          end

          new_truth_table
        end

        {
          :noreply,
          socket
          |> update(:truthTable, update_truth_table)
          |> update(:tries, &(&1 + 1))
          |> assign(:second, result)
        }

      _ ->
        {
          :noreply,
          socket
          |> assign(:first, nil)
          |> assign(:second, nil)
        }
    end
  end

  def handle_event("name-change", %{"name" => name}, socket) do
    {:noreply, assign(socket, :name, name)}
  end

  def handle_event("save-result", _, %{assigns: assigns} = socket) do
    create_score(assigns)
    {:noreply, assign(socket, :saved, true)}
  end

  def handle_event("play-again-click", _, socket) do
    possibleValues = 1..8

    values = Enum.concat(possibleValues, possibleValues)

    #      |> Enum.shuffle()

    truth_table = for index <- 0..15, into: %{}, do: {index, false}
    value_table = for index <- 0..15, into: %{}, do: {index, Enum.at(values, index)}

    {
      :noreply,
      socket
      |> assign(:saved, false)
      |> assign(:tref, nil)
      |> assign(:tries, 0)
      |> assign(:time, 0)
      |> assign(:valueTable, value_table)
      |> assign(:truthTable, truth_table)
      |> assign(:first, nil)
      |> assign(:second, nil)
      |> assign(:finish, false)
    }
  end

  def handle_info(:reset, socket) do
    {
      :noreply,
      socket
      |> assign(:first, nil)
      |> assign(:second, nil)
    }
  end

  def handle_info(:start_timer, socket) do
    {:ok, tref} = :timer.send_interval(1000, self(), :increment_time)
    {:noreply, assign(socket, :tref, tref)}
  end

  def handle_info(:finish_game, %{assigns: assigns} = socket) do
    :timer.cancel(assigns.tref)
    {:noreply, socket |> assign(:tref, nil) |> assign(:finish, true)}
  end

  def handle_info(:increment_time, socket) do
    case socket.assigns do
      %{:finish => finish} when finish -> {:noreply, socket}
      _ -> {:noreply, update(socket, :time, &(&1 + 1))}
    end
  end
end
