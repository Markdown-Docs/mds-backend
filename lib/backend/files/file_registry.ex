defmodule Backend.Files.FileRegistry do
  @moduledoc """
  Registy used for looking for active file processes pids
  """

  def start_link do
    IO.puts("Starting file registry")

    Registry.start_link(name: __MODULE__, keys: :unique)
  end

  def via_tuple(key) do
    {:via, Registry, {__MODULE__, key}}
  end

  def child_spec(_) do
    Supervisor.child_spec(
      Registry,
      id: __MODULE__,
      start: {__MODULE__, :start_link, []}
    )
  end
end
