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
    # Это сделано специально, так как без обнуления контента cast думает, что ничего не изменилось
    content = file.content
    file = %{file | content: ""}

    file
    |> File.changeset(%{content: content})
    |> Repo.update!()
  end

  def delete_file(file) do
    file
    |> Repo.delete()
  end
end
