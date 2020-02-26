defmodule LiveViewPatchWeb.SalesComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~L"""
    <tr>
    <td>
      <span><%= @code %></span>
    </td>
    <td><%= @ceil %></td>
    <td><%= @floor %></td>
    <td><%= @ref %></td>
    <td class= "flash <%= @price_class %>"><%= @price %></td>
    </tr>
    """
  end

  def mount(socket) do
    {:ok, socket}
  end
end
