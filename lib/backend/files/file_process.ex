defmodule Backend.Files.FileProcess do
  @moduledoc """
  FileProcess used to cashing file's text (just for reduce interaction with DB)
  """

  use GenServer, restart: :temporary
  alias Backend.Files

  # Время бездействия (например, 5 секунд)
  @timeout 5_000

  # API
  def start_link(file_id) do
    GenServer.start_link(__MODULE__, file_id, name: via_tuple(file_id))
  end

  def update_content(file_id, new_content) do
    GenServer.call(via_tuple(file_id), {:update_content, new_content})
  end

  defp via_tuple(file_id) do
    {:via, Registry, {Backend.Files.FileRegistry, file_id}}
  end

  # Callbacks
  def init(file_id) do
    # Загружаем файл из БД при запуске
    file = Files.get_file(file_id)
    {:ok, %{file: file, timer: reset_timer(nil)}}
  end

  def handle_call({:update_content, new_content}, _from, %{file: file, timer: timer} = state) do
    new_file = %{file | content: new_content}
    {:reply, :ok, %{state | file: new_file, timer: reset_timer(timer)}}
  end

  def handle_info(:timeout, %{file: file} = state) do
    # Сохраняем в БД перед завершением
    Files.save_file(file)
    {:stop, :normal, state}
  end

  defp reset_timer(timer) do
    # Отменяем старый таймер, если он существует
    if timer, do: Process.cancel_timer(timer)
    # Устанавливаем новый таймер
    Process.send_after(self(), :timeout, @timeout)
  end
end
