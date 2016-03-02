defmodule RtcRoom.ClientPool do
  use GenServer

  #API

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def add_client do
    GenServer.cast(__MODULE__, :add_client)
  end

  def client_count do
    GenServer.call(__MODULE__, :client_count)
  end

  #Callbacks

  def init([]) do
    {:ok, %{size: 0}}
  end

  def handle_cast(:add_client, %{size: size}) do
    {:noreply, %{size: size + 1}}
  end

  def handle_call(:client_count, _from, state) do
    {:reply, state.size, state}
  end
end
