defmodule Backend.Files.FileManager do
  @moduledoc """
  FileManager used for creating and interacting with FileProcess
  """

  alias Backend.Files.FileProcess

  def start_link() do
    IO.puts("Starting file manager")

    DynamicSupervisor.start_link(
      name: __MODULE__,
      strategy: :one_for_one
    )
  end

  defp start_child(file_id) do
    DynamicSupervisor.start_child(
      __MODULE__,
      {Backend.Files.FileProcess, file_id}
    )
  end

  @spec child_spec(any()) :: %{
          id: Backend.Files.FileManager,
          start: {Backend.Files.FileManager, :start_link, []},
          type: :supervisor
        }
  def child_spec(_arg) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :supervisor
    }
  end

  def get_or_start_process(file_id) do
    case Registry.lookup(Backend.Files.FileRegistry, file_id) do
      [] ->
        # Процесс не существует — запускаем новый
        start_child(file_id)
        :ok

      [{_pid, _}] ->
        # Процесс уже существует
        :ok
    end
  end

  def update_file_content(file_id, content) do
    # Убедимся, что процесс существует
    get_or_start_process(file_id)

    # Обновляем содержимое файла в процессе
    FileProcess.update_content(file_id, content)
  end
end
