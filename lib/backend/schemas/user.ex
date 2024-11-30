defmodule Backend.User do
  @moduledoc """
  PostgreSQL schema: `User`
  > Managed by *Ecto ORM*
  """
  use Ecto.Schema

  schema "users" do
    field :username, :string
    field :password, :string
  end
end
