defmodule Backend.File do
  use Ecto.Schema

  schema "files" do
    field :filename, :string
    field :created_at, :date
  end
end
