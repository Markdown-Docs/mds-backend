defmodule BackendWeb.FileChannel do
  @moduledoc """
  Websocket channel for each .mds file
  """
  use Phoenix.Channel

  def join("file:" <> _room_id, _params, socket) do
    {:ok, socket}
  end

  def handle_in("edit", %{"content" => content}, socket) do
    # Рассылка обновлений всем клиентам
    broadcast!(socket, "update", %{content: content})
    {:noreply, socket}
  end
end
