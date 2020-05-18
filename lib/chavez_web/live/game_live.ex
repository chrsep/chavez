defmodule ChavezWeb.GameLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    possibleValues = 1..8

    values =
      Enum.concat(possibleValues, possibleValues)
      |> Enum.shuffle()

    truthTable = for index <- 0..15, into: %{}, do: {index, false}
    valueTable = for index <- 0..15, into: %{}, do: {index, Enum.at(values, index)}

    socket =
      socket
      #      |> assign(:timer_ref, nil)
      |> assign(:tries, 0)
      |> assign(:time, 0)
      |> assign(:valueTable, valueTable)
      |> assign(:truthTable, truthTable)
      |> assign(:first, nil)
      |> assign(:second, nil)

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
          :timer.send_interval(1000, self(), :increment_time)
        end

        update_truth_table = fn old_truth_table ->
          first_value = values[first]
          second_value = values[result]

          new_truth_table =
            case first_value do
              ^second_value -> %{old_truth_table | first => true, result => true}
              _ -> old_truth_table
            end

          #          if new_truth_table |> Map.values() |> Enum.all?() do
          #            :timer.cancel(timer_ref)
          #          end
          #          new_truth_table
        end

        {
          :noreply,
          socket
          |> update(:truthTable, update_truth_table)
          |> update(:tries, &(&1 + 1))
          |> assign(:second, result)
          #          |> assign(:timer_ref, timer_ref)
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

  def handle_info(:reset, socket) do
    {
      :noreply,
      socket
      |> assign(:first, nil)
      |> assign(:second, nil)
    }
  end

  def handle_info(:increment_time, socket) do
    {:noreply, update(socket, :time, &(&1 + 1))}
  end
end
