defmodule RideWeb.PageController do
  use RideWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
