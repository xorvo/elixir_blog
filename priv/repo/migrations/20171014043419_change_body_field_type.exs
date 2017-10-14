defmodule ElixirBlog.Repo.Migrations.ChangeBodyFieldType do
  use Ecto.Migration

  def change do
    alter table("articles") do
      modify :body, :text
    end

    alter table("comments") do
      modify :body, :text
    end
  end
end
