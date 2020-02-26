defmodule LiveViewPatchWeb.HomeLive do
  use Phoenix.LiveView
  alias LiveViewPatchWeb.PageView, as: View

  @sales_region [
    %{code: "New York", ceil: 10000, floor: 6000, ref: 8000, price: 8000},
    %{code: "Chicago", ceil: 10000, floor: 6_000, ref: 8000, price: 100_000}
  ]
  @sales_global [
    %{code: "Brazil", ceil: 2_100_000, floor: 16000, ref: 58000, price: 98000},
    %{code: "USA", ceil: 190_000, floor: 66000, ref: 28000, price: 110_000},
    %{code: "Vietnam", ceil: 950_000, floor: 730_000, ref: 240_000, price: 145_000}
  ]

  @tabs ["sales", "kpi"]
  @sales ["region", "global"]

  def render(assigns) do
    View.render("#{assigns.tab}.html", assigns)
  end

  def mount(_params, _session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :stream)
    {:ok, assign(socket, data: @sales_global, sales: "global", tab: "sales")}
  end

  def handle_params(%{"tab" => tab}, _uri, socket) do
    cond do
      connected?(socket) ->
        case tab do
          tab when tab in @tabs ->
            socket = assign(socket, tab: tab)
            {:noreply, socket}

          _ ->
            {:noreply, socket}
        end

      true ->
        {:noreply, socket}
    end
  end

  def handle_params(%{"sales" => sales}, _uri, socket) do
    IO.puts("Check IN SALES before update: #{inspect(socket.assigns.data)} ")

    cond do
      connected?(socket) ->
        case sales do
          sales when sales in @sales ->
            cond do
              sales == "region" ->
                socket = assign(socket, data: @sales_region, sales: "region", tab: "sales")
                {:noreply, socket}

              sales == "global" ->
                socket = assign(socket, data: @sales_global, sales: "global", tab: "sales")
                {:noreply, socket}

              true ->
                {:noreply, socket}
            end

          _ ->
            {:noreply, socket}
        end

      true ->
        IO.puts("Check NOT CONNECTED")
        {:noreply, socket}
    end
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_info(:stream, socket) do
    if connected?(socket) && socket.assigns.tab == "sales" do
      cond do
        socket.assigns.sales == "region" ->
          send_update(LiveViewPatchWeb.SalesComponent,
            id: "Chicago",
            price: Enum.random(100_000..145_000)
          )

          send_update(LiveViewPatchWeb.SalesComponent,
            id: "New York",
            price: Enum.random(100_000..145_000)
          )

        socket.assigns.sales == "global" ->
          send_update(LiveViewPatchWeb.SalesComponent,
            id: "Vietnam",
            price: Enum.random(100_000..145_000)
          )

          send_update(LiveViewPatchWeb.SalesComponent,
            id: "Brazil",
            price: Enum.random(100_000..145_000)
          )

          send_update(LiveViewPatchWeb.SalesComponent,
            id: "USA",
            price: Enum.random(100_000..145_000)
          )
      end
    end

    {:noreply, socket}
  end
end
