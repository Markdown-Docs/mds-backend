defmodule Backend.Files do
  @moduledoc """
  Context for File
  """
  alias Backend.Repo
  alias Backend.Files.File

  def get_file(id) do
    Repo.get(File, id)
  end

  def create_file(attrs \\ %{}) do
    %File{}
    |> File.changeset(attrs)
    |> Repo.insert()
  end

  def save_file(file) do
    file
    |> File.changeset(%{})
    |> Repo.update()
  end

  def delete_file(file) do
    file
    |> Repo.delete()
  end
end
