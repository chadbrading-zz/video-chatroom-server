defmodule RtcRoom.PageController do
  use RtcRoom.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
