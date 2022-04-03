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
    json = Map.get(values, "json")

    case Jason.decode(json) do
      {:ok, elixir_map} ->
        socket =
          socket
          |> assign(json: json)
          |> assign(error: nil)
          |> assign(elixir_map: elixir_map)

        {:noreply, socket}

      {:error, _reason} ->
        socket =
          socket
          |> assign(error: "Error when decoding Json to Elixir Map")
          |> assign(elixir_map: "")

        {:noreply, socket}
    end
  end
end
