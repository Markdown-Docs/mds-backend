defmodule BackendWeb.FileController do
  alias Backend.Files
  use BackendWeb, :controller

  def get_file(conn, %{"id" => id}) do
    file = Files.get_file(id)

    case file do
      nil ->
        conn
        |> put_status(404)
        |> json(%{"message" => "File with id " <> id <> " does not exist"})

      _ ->
        conn
        |> put_status(200)
        |> json(file)
    end
  end

  def get_files(conn, _param) do
    files = Files.get_files()

    conn
    |> put_status(200)
    |> json(files)
  end

  def create_file(conn, %{"name" => name}) do
    case Files.create_file(%{"name" => name, "content" => ""}) do
      {:ok, file} ->
        conn
        |> put_status(201)
        |> json(file)

      {:error, _} ->
        conn
        |> put_status(500)
        |> json(%{"message" => "Error occured"})
    end
  end

  def delete_file(conn, %{"id" => id}) do
    file = Files.get_file(id)

    if file == nil do
      conn
      |> put_status(404)
      |> json(%{"message" => "File with id " <> id <> " not found"})
    else
      case Files.delete_file(file) do
        {:ok, _} ->
          conn
          |> put_status(200)
          |> json(%{"message" => "File with id " <> id <> " has been deleted successfully"})

        {:error, _} ->
          conn
          |> put_status(500)
          |> json(%{"message" => "Error occured"})
      end
    end
  end
end
