defmodule LiveViewPatchWeb.PageController do
  use LiveViewPatchWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
