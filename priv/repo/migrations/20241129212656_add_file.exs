defmodule Backend.Repo.Migrations.AddFile do
  use Ecto.Migration

  def change do
    create table(:files) do
      add :filename, :string
      add :created_at, :date
    end
  end
end
