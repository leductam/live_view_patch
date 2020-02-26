defmodule LiveViewPatchWeb.TabComponent do
  use Phoenix.LiveComponent
  alias LiveViewPatchWeb.PageView, as: View

  def render(assigns) do
    View.render("tab.html", assigns)
  end
end
