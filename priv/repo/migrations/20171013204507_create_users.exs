defmodule ElixirBlog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password, :string
      add :display_name, :string
      add :bio, :string
      add :tags, {:array, :string}

      timestamps()
    end

  end
end
