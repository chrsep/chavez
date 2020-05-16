defmodule ChavezWeb.PageController do
  use ChavezWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
