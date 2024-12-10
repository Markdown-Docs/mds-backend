defmodule BackendWeb.FileChannel do
  @moduledoc """
  Websocket channel for each .mds file
  """
  alias Backend.Files
  alias Backend.Files.FileManager
  use Phoenix.Channel

  def join("file:" <> file_id, _params, socket) do
    case Files.get_file(file_id) do
      nil -> {:error, %{reason: "File with id " <> file_id <> " does not exist"}}
      _ -> {:ok, assign(socket, :file_id, file_id)}
    end
  end

  def handle_in("edit", %{"content" => content}, socket) do
    # Получаем file_id из socket.assigns
    file_id = socket.assigns.file_id

    # Вызываем FileManager для обновления содержимого файла
    FileManager.update_file_content(file_id, content)

    # Рассылаем обновления всем клиентам
    broadcast!(socket, "update", %{content: content})
    {:noreply, socket}
  end
end
