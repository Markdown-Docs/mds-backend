defmodule Backend.Repo.Migrations.AddFile do
  use Ecto.Migration

  def change do
    create table(:files) do
      add :name, :string, null: false
      add :content, :string, size: 10000
    end
  end
end
