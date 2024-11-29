defmodule Backend.User do
  use Ecto.Schema

  schema "users" do
    field :username, :string
    field :password, :string
  end
end
