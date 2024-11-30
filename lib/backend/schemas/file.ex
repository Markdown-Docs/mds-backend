defmodule Backend.File do
  @moduledoc """
  PostgreSQL schema: `File`
  > Managed by *Ecto ORM*
  """
  use Ecto.Schema

  schema "files" do
    field :filename, :string
    field :created_at, :date
  end
end
