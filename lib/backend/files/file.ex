defmodule Backend.Files.File do
  @moduledoc """
  PostgreSQL schema: `File`
  > Managed by *Ecto ORM*
  """
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name, :content]}
  schema "files" do
    field :name, :string
    field :content, :string
  end

  def changeset(file, attrs) do
    file
    |> cast(attrs, [:name, :content], empty_values: [:content])
    |> validate_required([:name])
  end
end
