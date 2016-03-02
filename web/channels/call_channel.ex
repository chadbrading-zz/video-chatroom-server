defmodule Rtc.CallChannel do
  use Phoenix.Channel

  def join("call", auth_msg, socket) do
    RtcRoom.ClientPool.add_client
    client_count = RtcRoom.ClientPool.client_count
    send self, {:after_join, client_count}
    {:ok, client_count, socket}
  end

  def handle_in("message", %{"body" => body}, socket) do
    broadcast! socket, "message", %{body: body}
    {:noreply, socket}
  end

  def handle_out("message", payload, socket) do
    push socket, "message", payload
    {:noreply, socket}
  end

  def handle_info({:after_join, client_count}, socket) do
    {:ok, payload} = JSON.encode(%{id: client_count})
    broadcast! socket, "message", %{body: payload}
    {:noreply, socket}
  end
end
