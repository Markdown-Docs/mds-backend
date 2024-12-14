defmodule BackendWeb.FileChannel do
  use Phoenix.Channel

  alias Backend.Files
  alias Backend.Files.FileManager
  alias Backend.Parsers.MdsParser
  alias BackendWeb.PreviewChannel

  require Logger

  def join("file:" <> file_id, _params, socket) do
    case Files.get_file(file_id) do
      nil -> {:error, %{reason: "File with id " <> file_id <> " does not exist"}}
      _ -> {:ok, assign(socket, :file_id, file_id)}
    end
  end

  def handle_in("edit", %{"content" => content}, socket) do
    file_id = socket.assigns.file_id

    Logger.debug("HANDLED edit INCOMING ON file:#{file_id}")
    Logger.debug("  Parameters: #{inspect(%{"content" => content})}")

    FileManager.update_file_content(file_id, content)
    broadcast!(socket, "update", %{content: content})

    Task.Supervisor.start_child(Backend.TaskSupervisor, fn ->
      case MdsParser.parse(content) do
        {:ok, html} ->
          PreviewChannel.send_preview(file_id, html)
          Logger.debug("SENT preview BACK ON preview:#{file_id}")
          Logger.debug("  HTML Content: #{String.slice(html, 0..100)}...") # Limit log size

        {:error, reason} ->
          Logger.error("Parser error: #{inspect(reason)}")
      end
    end)

    {:noreply, socket}
  end
end
