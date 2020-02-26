defmodule LiveViewPatchWeb.PageView do
  use LiveViewPatchWeb, :view

  def get_class(assigns) do
    cond do
      assigns.price === assigns.ceil -> "ceil"
      assigns.price === assigns.floor -> "floor"
      assigns.price === assigns.ref -> "ref"
      assigns.price > assigns.ref -> "up"
      assigns.price < assigns.ref -> "down"
      true -> "white"
    end
  end
end
