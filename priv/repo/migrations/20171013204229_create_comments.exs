defmodule ElixirBlog.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :title, :string
      add :body, :string
      add :article_id, :integer
      add :user_id, :integer

      timestamps()
    end

  end
end
