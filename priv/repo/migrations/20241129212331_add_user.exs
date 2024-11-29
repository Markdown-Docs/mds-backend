defmodule Backend.Repo.Migrations.AddUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password, :string
    end
  end
end
