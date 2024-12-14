defmodule BackendWeb.UserSocket do
  use Phoenix.Socket

  ## Каналы
  channel "file:*", BackendWeb.FileChannel
  channel "preview:*", BackendWeb.PreviewChannel

  # Здесь можно добавить авторизацию (опционально)
  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  # Укажите уникальный идентификатор пользователя, если нужно. Например, `socket.assigns.user_id`.
  def id(_socket), do: nil
end
