defmodule RideWeb.PageController do
  use RideWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def petal(conn, _params) do
    render(conn, "petal.html")
  end
end
