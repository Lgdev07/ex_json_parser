defmodule ExJsonParserWeb.HomeLive do
  @moduledoc false

  use Phoenix.LiveView
  use Phoenix.HTML

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(json: "")
      |> assign(error: nil)
      |> assign(elixir_map: "")

    {:ok, socket}
  end

  @impl true
  def handle_event(_action, values, socket) do
    case format_json(values, socket) do
      {:ok, socket} ->
        {:noreply, socket}

      {:error, _reason} ->
        socket =
          socket
          |> assign(error: "Error when decoding Json to Elixir Map")
          |> assign(elixir_map: "")

        {:noreply, socket}
    end
  end

  defp format_json(%{"json" => new_json}, %{assigns: %{json: prev_json}} = socket) do
    cond do
      new_json != prev_json ->
        with {:ok, new_elixir_map} <- Jason.decode(new_json) do
          {:ok,
           socket
           |> assign(json: new_json)
           |> assign(error: nil)
           |> assign(elixir_map: inspect(new_elixir_map))}
        end

      true ->
        {:ok, socket}
    end
  end
end
