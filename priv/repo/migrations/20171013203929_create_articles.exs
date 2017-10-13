defmodule ElixirBlog.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :body, :string
      add :author_id, :integer
      add :tags, {:array, :string}

      timestamps()
    end

  end
end
