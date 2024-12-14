defmodule BackendWeb.PreviewChannel do
  @moduledoc """
  Websocket channel for each **converted** .mds file
  """
  use Phoenix.Channel

  def join("preview:" <> file_id, _params, socket) do
    # store process PID in ETS (Erlang Term Storage) to listen to messages in topic
    Phoenix.PubSub.subscribe(Backend.PubSub, "preview:#{file_id}")
    {:ok, assign(socket, :file_id, file_id)}
  end

  # Отправка готового превью
  def send_preview(file_id, html) do
    # find all subscribed to preview topic procs in ETS (Erlang Term Storage) and send them message
    Phoenix.PubSub.broadcast(Backend.PubSub, "preview:#{file_id}", {:preview, html})
  end

  def handle_info({:preview, html}, socket) do
    push(socket, "preview", %{html: html})
    {:noreply, socket}
  end
end
