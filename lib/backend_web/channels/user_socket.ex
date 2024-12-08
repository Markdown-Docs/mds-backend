defmodule BackendWeb.UserSocket do
  use Phoenix.Socket

  ## Каналы
  # Это маршрут, на который будет подписан клиент
  channel "file:*", BackendWeb.FileChannel

  # Здесь можно добавить авторизацию (опционально)
  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  # Укажите уникальный идентификатор пользователя, если нужно. Например, `socket.assigns.user_id`.
  def id(_socket), do: nil
end
